# Paperpile Briefer

Paperpileに追加した論文を、翌朝6時に落合陽一フォーマットのMarkdownへまとめるためのローカル自動化です。

Paperpileはライブラリをエクスポートできます。このツールはJSONまたはBibTeXを入力にして、前回処理済みとの差分だけを日次briefにします。

## できること

- Paperpileエクスポートから新規追加論文だけを抽出
- Codex CLIで落合陽一フォーマットのMarkdownを生成
- そのまま追加質問するための`chat/YYYY-MM-DD.md`を生成
- `briefs/README.md`と`briefs/latest.md`を更新して、GitHub/Obsidianから読みやすくする
- Markdownをrepoへcommit/push
- 任意でObsidianのintakeディレクトリへコピー

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

- `briefs/YYYY-MM-DD.md`: 読むためのMarkdown
- `briefs/README.md`: GitHub/Obsidianで開く一覧ページ
- `briefs/latest.md`: 最新briefへの固定入口
- `chat/YYYY-MM-DD.md`: ChatGPT/Codexに貼って深掘りするためのプロンプト
- `raw/YYYY-MM-DD.json`: Paperpile差分の生データ
- `state/seen.json`: 処理済みID

## 翌朝6時に実行

`tech/papers` 配下の自動実行は systemd user timer に統一しています。

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
OnCalendar=*-*-* 06:00
Persistent=true

[Install]
WantedBy=timers.target
```

```bash
systemctl --user enable --now paperpile-briefer.timer
```

## Obsidianへpushする

`.env`で次を設定します。

```bash
EXPORT_TO_OBSIDIAN=true
OBSIDIAN_EXPORT_DIR=/home/hiroki/Obsidian/intake/paperpile-briefs
```

Obsidian側では`briefs`のMarkdownを読むだけでなく、末尾の「追加で聞く」から`chat/YYYY-MM-DD.md`を開いて、そのままチャットへ投げられます。

## 注意

- Paperpile側の自動エクスポートがない場合、6時より前にエクスポートファイルが更新されている必要があります。
- 要約生成は`codex exec`を使います。systemd user service から実行しても同じ`codex`認証が使える状態にしてください。
- 要約生成やpushが失敗した場合、`state/seen.json`は更新されないため、次回に同じ論文が再処理されます。
