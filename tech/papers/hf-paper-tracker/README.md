# HF Paper Tracker

Hugging Face Daily Papers を自動追跡し、テーマ別に分類・要約・スコアリングして Gmail に届けるシステム。生成物の保存先は設定で切り替えられ、repo 内完結にも Obsidian へのエクスポートにも対応する。

## アーキテクチャ

```
systemd user timer (ローカルPC / サーバー)
  ├── uv run fetch_papers.py        ← HF API からデータ取得（LLM なし・依存はスクリプト内 PEP 723）
  ├── codex exec "..."              ← OpenAI Codex CLI で分析（日次: raw JSON → md／週次: 結合日次 → 週次 md）
  ├── uv run enrich_skip_links.py   ← スキップ論文を raw JSON でリンク付きに上書き
  ├── uv run send_email.py         ← Gmail SMTP で通知
  └── git commit/push               ← 結果を設定した保存先に蓄積
```

- 日次・週次の自動分析は **OpenAI Codex CLI** の `codex exec`（`scripts/run_daily.sh` / `run_weekly.sh` 内）
- 分析ロジックは `CLAUDE.md` に一元管理
- ローカルで手動実行する時も自動実行も同じ設定

## セットアップ

### 1. リポジトリを用意

```bash
git clone <your-repo-url>
cd hf-paper-tracker
chmod +x scripts/run_daily.sh scripts/run_weekly.sh
```

Python スクリプトは [uv](https://docs.astral.sh/uv/) の **PEP 723 インライン依存**で実行する（`pyproject.toml` は使わない）。初回実行時に `uv` が依存を解決する。

```bash
# uv 未導入の場合（公式インストーラ）
curl -LsSf https://astral.sh/uv/install.sh | sh
# または: brew install uv
```

依存の追加・更新はリポジトリ直下で次のようにする（スクリプト先頭の `# /// script` ブロックが更新される）。

```bash
uv add requests --script scripts/fetch_papers.py
```

手動実行の例:

```bash
uv run scripts/fetch_papers.py
uv run scripts/enrich_skip_links.py papers/daily/2026-03-22.md papers/daily/raw/2026-03-22.json
uv run scripts/send_email.py papers/daily/2026-03-22.md
```

既存の日次 `.md` にだけスキップリンクを付け直す場合も上の `enrich_skip_links.py` 行を使う（第1引数: md、第2引数: 同日の raw JSON）。

### 2. OpenAI Codex CLI が使えることを確認

```bash
codex --version    # インストール確認
codex exec --help  # 利用可能か確認
```

Codex CLI の認証は各環境の手順に従う（`run_daily.sh` / `run_weekly.sh` と同じ `codex` が systemd user service でも使えること）。

### 3. Gmail アプリパスワードを設定

```bash
cat > .env << 'EOF'
GMAIL_ADDRESS=your@gmail.com
GMAIL_APP_PASSWORD=xxxx xxxx xxxx xxxx

# 生成物の保存先
WORK_DIR=./papers
LOG_DIR=./logs
DAILY_OUTPUT_DIR=./papers/daily
DAILY_RAW_DIR=./papers/daily/raw
WEEKLY_OUTPUT_DIR=./papers/weekly

# Obsidian へのエクスポートは任意
EXPORT_TO_OBSIDIAN=false
# EXPORT_TO_OBSIDIAN=true
# OBSIDIAN_EXPORT_DAILY_DIR=/home/hiroki/Obsidian/intake/hf-papers/daily
# OBSIDIAN_EXPORT_WEEKLY_DIR=/home/hiroki/Obsidian/intake/hf-papers/weekly
EOF
```

アプリパスワードの取得:
1. https://myaccount.google.com/security → 2段階認証を有効化
2. https://myaccount.google.com/apppasswords → アプリ名 `HF Paper Tracker` で作成
3. 16文字のパスワードを `.env` に記載

### 4. 出力先を設定する

デフォルトでは生成物は repo 内に保存される。

- `WORK_DIR`: 生成物のルートディレクトリ
- `LOG_DIR`: 実行ログの保存先
- `DAILY_OUTPUT_DIR`: 日次 markdown の保存先
- `DAILY_RAW_DIR`: HF API の raw JSON 保存先
- `WEEKLY_OUTPUT_DIR`: 週次 markdown の保存先

Obsidian にもコピーしたい場合だけ、次を有効化する。

- `EXPORT_TO_OBSIDIAN=true`
- `OBSIDIAN_EXPORT_DAILY_DIR=/path/to/Obsidian/intake/hf-papers/daily`
- `OBSIDIAN_EXPORT_WEEKLY_DIR=/path/to/Obsidian/intake/hf-papers/weekly`

別サーバーでは `EXPORT_TO_OBSIDIAN=false` のままでよい。固定パスをコードに埋める必要はない。

### 5. systemd user timer を設定

`tech/papers` 全体の標準デプロイコマンドを使う。

```bash
cd /home/hiroki/work/knowledge/tech/papers
./scripts/deploy_systemd_user_timers.sh
```

HF Paper Tracker だけ更新したい場合:

```bash
./scripts/install_systemd_user_timer.sh
```

これで次の user units が作成・有効化される。

- `hf-paper-tracker-daily.timer`: 月曜〜金曜 09:00
- `hf-paper-tracker-weekly.timer`: 日曜 10:00

状態確認:

```bash
systemctl --user list-timers 'hf-paper-tracker*'
systemctl --user status hf-paper-tracker-daily.service hf-paper-tracker-weekly.service
journalctl --user -u hf-paper-tracker-daily.service -u hf-paper-tracker-weekly.service --no-pager
```

### 6. 動作確認

```bash
source .env && export GMAIL_ADDRESS GMAIL_APP_PASSWORD
./scripts/run_daily.sh
```

## ディレクトリ構造

```
hf-paper-tracker/
├── CLAUDE.md                    ← 設定の一元管理（@ で prompts/ を参照）
├── .env                         ← Gmail認証（gitignore済み）
├── prompts/                     ← 詳細プロンプト集（CLAUDE.mdから自動参照）
│   ├── daily_intake_prompt.md   ← 高速モード・テーマ特化モード等
│   ├── relevance_filter_prompt.md ← スコアリング詳細・比較版等
│   ├── deep_dive_dialogue_prompt.md ← Phase2-3テンプレ・テーマ別質問集
│   └── weekly_trend_analysis_prompt.md ← 運用Tips・検索ガイド
├── scripts/
│   ├── install_systemd_user_timer.sh ← systemd user timer を作成
│   ├── run_daily.sh             ← 日次systemd エントリポイント
│   ├── run_weekly.sh            ← 週次systemd エントリポイント
│   ├── fetch_papers.py          ← HF API → JSON（`uv run`・依存はファイル先頭の `/// script`）
│   ├── enrich_skip_links.py     ← 日次 md の「スキップした論文」を raw JSON でリンク付きに上書き
│   └── send_email.py            ← Gmail SMTP 送信（同上・標準ライブラリのみ）
├── papers/
│   ├── daily/
│   │   ├── raw/                 ← 生データ (JSON)
│   │   └── 2026-03-22.md        ← 分析結果
│   └── weekly/
│       └── 2026-W13.md          ← 週次分析
└── logs/                        ← 実行ログ
```

上の構成はデフォルト値。`.env` で保存先を変えた場合は、その設定先に生成される。

## ローカルでの対話利用

```bash
cd hf-paper-tracker

# 論文の深掘り
claude "https://arxiv.org/abs/2403.xxxxx を深掘り分析して"

# 関連度フィルタ
claude "今週の論文に関連度フィルタをかけて"

# 週次分析（手動）
./scripts/run_weekly.sh
```

## 自動実行の運用

`tech/papers` 配下のスケジューラは systemd user timer に統一する。共通ルールは親ディレクトリの `AGENTS.md` を参照。

```bash
systemctl --user list-timers 'hf-paper-tracker*'
systemctl --user status hf-paper-tracker-daily.service hf-paper-tracker-weekly.service
journalctl --user -u hf-paper-tracker-daily.service -u hf-paper-tracker-weekly.service --no-pager
```
