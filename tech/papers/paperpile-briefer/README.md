# Paperpile Briefer

Paperpileに追加した論文を、翌朝6時に落合陽一フォーマットのMarkdownへまとめるためのローカル自動化です。

Paperpileはライブラリをエクスポートできます。このツールはJSONまたはBibTeXを入力にして、前回処理済みとの差分だけを日次briefにします。

## できること

- Paperpileエクスポートから新規追加論文だけを抽出
- ローカルPDFを読める場合は本文抽出し、Codex CLIで論文ごとの落合陽一フォーマットMarkdownを生成
- そのまま追加質問するための論文別`chat/YYYY-MM-DD/*.md`を生成
- `briefs/README.md`と`briefs/latest.md`を更新して、GitHub/Obsidianから読みやすくする
- 任意でMarkdownをrepoへcommit/pushし、別マシンのCodexから深掘りできるようにする
- 任意でObsidianのintakeディレクトリへコピー
- 任意でモバイル通知を送る

## セットアップ

```bash
cp .env.example .env
$EDITOR .env
chmod +x scripts/run_daily.sh
```

`.env`の`PAPERPILE_EXPORT_PATH`にPaperpileから書き出したJSONまたはBibTeXのパスを指定します。

```bash
PAPERPILE_EXPORT_PATH=/home/hiroki/Downloads/paperpile-export.json
```

Paperpile export内のPDFパスが相対パスの場合は、基準ディレクトリも指定できます。PDFパスがないarXiv論文は、デフォルトでタイトル検索からPDFを取得して本文抽出します。

```bash
PAPERPILE_PDF_BASE_DIR=/home/hiroki/Paperpile
PDF_TEXT_MAX_CHARS=60000
PDF_TEXT_MAX_PAGES=30
ARXIV_PDF_FALLBACK=true
```

Google Driveなどからexportを同期している場合は、実行前に呼ぶスクリプトも指定できます。

```bash
PAPERPILE_SYNC_SCRIPT=/home/hiroki/Obsidian/scripts/sync_papers.sh
```

設定確認:

```bash
set -a; source .env; set +a
uv run scripts/validate_config.py
```

## 手動実行

初回に既存ライブラリをすべて要約したくない場合は、現在のPaperpile exportを処理済みとして登録します。

```bash
uv run scripts/bootstrap_seen.py --export "$PAPERPILE_EXPORT_PATH" --state ./state/seen.json
```

以後に追加された論文だけが日次briefの対象になります。

```bash
./scripts/run_daily.sh
```

生成物:

- `briefs/YYYY-MM-DD.md`: その日の論文別briefへの目次
- `briefs/YYYY-MM-DD/*.md`: 論文ごとのMarkdown brief
- `briefs/README.md`: GitHub/Obsidianで開く一覧ページ
- `briefs/latest.md`: 最新briefへの固定入口
- `chat/YYYY-MM-DD/*.md`: ChatGPT/Codexに貼って深掘りするための論文別プロンプト
- `raw/YYYY-MM-DD.json`: Paperpile差分の生データ
- `raw/papers/YYYY-MM-DD/*.json`: 論文別brief生成用の1本入りJSON。PDF本文を抽出できた場合は`pdf_text`を含む
- `state/seen.json`: 処理済みID
- `logs/activity.md`: 新規論文0件など、briefに残さない作業ログ

## GitHub同期と深掘り

別サーバーで自動生成し、Codexを動かす別マシンで対話的に深掘りする場合は、`.env`で次を有効にします。

```bash
PUSH_TO_GIT=true
```

この場合、`run_daily.sh`は実行前に現在ブランチの`origin`を`git pull --rebase`し、生成後に`briefs/`、`chat/`、`logs/activity.md`をcommit/pushします。追加論文が0件の日も`logs/activity.md`に記録してGitHubへ同期します。pushが成功した後に`state/seen.json`を更新するため、GitHub同期に失敗した論文を処理済みにしません。

`raw/`、`state/`、日別の詳細ログ`logs/YYYY-MM-DD.log`はローカル運用データとして`.gitignore`対象のままです。Codexでの通常の深掘りは、GitHub経由で同期された`briefs/YYYY-MM-DD.md`と`chat/YYYY-MM-DD/*.md`から始めます。

## 翌朝4時30分に実行

macOSでは `launchd` user agentを使います。

```bash
cd /Users/hiroki-iida/works/knowledge-clawler/tech/papers/paperpile-briefer
PAPERPILE_EXPORT_PATH="$HOME/Library/CloudStorage/GoogleDrive-mesitahiro@gmail.com/マイドライブ/Paperpile/paperpile.bib" \
PUSH_TO_GIT=false ./scripts/install_launchd_user_agent.sh
```

Linuxサーバーでは、従来どおりsystemd user timerを使います。

標準は親ディレクトリから一括デプロイします。

```bash
cd /home/hiroki/work/knowledge/tech/papers
./scripts/deploy_systemd_user_timers.sh
```

Paperpile Briefer だけ更新したい場合:

```bash
./scripts/install_systemd_user_timer.sh
```

手で置く場合は次の内容です。

```ini
# ~/.config/systemd/user/paperpile-briefer.service
[Service]
Type=oneshot
WorkingDirectory=/home/hiroki/work/knowledge/tech/papers/paperpile-briefer
ExecStart=/bin/bash scripts/run_daily.sh
```

```ini
# ~/.config/systemd/user/paperpile-briefer.timer
[Timer]
OnCalendar=*-*-* 04:30
Persistent=true

[Install]
WantedBy=timers.target
```

```bash
systemctl --user enable --now paperpile-briefer.timer
```

## Obsidianへコピーする

`.env`で次を設定します。

```bash
EXPORT_TO_OBSIDIAN=false
OBSIDIAN_EXPORT_DIR=/home/hiroki/Obsidian/intake/paperpile-briefs
```

通常はGitHub/repoを正とするため `EXPORT_TO_OBSIDIAN=false` のままにする。Obsidianへもコピーしたい場合だけ `EXPORT_TO_OBSIDIAN=true` にする。

## モバイル通知とチャット

`.env`でどれかを設定すると、日次実行後にモバイルへ通知します。

```bash
# ntfy mobile app
NTFY_TOPIC=your-private-topic

# またはwebhook
MOBILE_WEBHOOK_URL=https://example.com/webhook

# またはGmail通知
GMAIL_ADDRESS=your@gmail.com
GMAIL_APP_PASSWORD=xxxx xxxx xxxx xxxx
```

Gmail認証を `hf-paper-tracker/.env` に置いている場合、デフォルトでその `GMAIL_*` だけを通知スクリプトが読みます。

Hermesが設定済みの場合、論文別briefの生成後にSlackへ新規論文を投稿できます。論文ごとに親投稿へタイトル・著者・論文リンクを投稿し、そのスレッドへ対応する論文のまとめを返信します。リンクはPaperpileのURL、DOI、arXiv IDの順に使い、いずれもない場合はarXivタイトル検索リンクを使います。デフォルトの投稿先はIida privateの `#daily-papers`（`C0C4MDEGSUU`）です。

```bash
PAPERPILE_SLACK_ENABLED=true
PAPERPILE_SLACK_TARGET=slack:C0C4MDEGSUU
```

投稿先のSlackチャンネルには、あらかじめHermes botを参加させてください。Slack送信に失敗した場合は、論文ごとの親投稿IDを保存し、次回実行時に重複投稿を避けながら未完了のスレッド返信だけを再送します。

モバイルでは Obsidian Mobile で `paperpile-briefs/YYYY-MM-DD.md` を開き、気になる論文の `chat` リンクを開いて本文を ChatGPT mobile に貼ります。

## skipの意味

ログに出る `skip` は主に2種類あります。

- `fetch_new_papers.py` 側: `state/seen.json` に既にあるPaperpile IDは新規brief対象から除外する。
- `bib_to_wiki.py` 側: `wiki/papers/` に既に同名スタブがある論文は再作成しない。

どちらも「失敗して読み飛ばした」という意味ではありません。

## 注意

- Paperpile側の自動エクスポートがない場合、6時より前にエクスポートファイルが更新されている必要があります。
- 要約生成は`codex exec`を使います。systemd user service から実行しても同じ`codex`認証が使える状態にしてください。
- PDF本文抽出はPaperpile export内のローカルPDFパスを優先します。パスがないarXiv論文はタイトル検索からPDFを取得して抽出します。PDFが見つからない、ファイルがない、スキャンPDFでテキスト抽出できない場合は従来通りメタデータ中心のbriefになります。
- 要約生成またはGitHub同期が失敗した場合、`state/seen.json`は更新されないため、次回に同じ論文が再処理されます。
