#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
. "$SCRIPT_DIR/cron_env.sh"

REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_DIR"

if [ -f .env ]; then
  set -a
  # shellcheck disable=SC1091
  source .env
  set +a
fi

DATE="${DATE:-$(date +%Y-%m-%d)}"
OUTPUT_DIR="${OUTPUT_DIR:-$REPO_DIR/briefs}"
RAW_DIR="${RAW_DIR:-$REPO_DIR/raw}"
PAPER_RAW_DIR="${PAPER_RAW_DIR:-$RAW_DIR/papers}"
CHAT_DIR="${CHAT_DIR:-$REPO_DIR/chat}"
STATE_DIR="${STATE_DIR:-$REPO_DIR/state}"
LOG_DIR="${LOG_DIR:-$REPO_DIR/logs}"
STATE_FILE="$STATE_DIR/seen.json"
RAW_FILE="$RAW_DIR/$DATE.json"
MANIFEST_FILE="$RAW_DIR/$DATE.manifest.json"
OUTPUT_FILE="$OUTPUT_DIR/$DATE.md"
CHAT_FILE="$CHAT_DIR/$DATE.md"
LOG_FILE="$LOG_DIR/$DATE.log"
ACTIVITY_LOG="$LOG_DIR/activity.md"

copy_to_obsidian() {
  if [ "${EXPORT_TO_OBSIDIAN:-false}" != "true" ]; then
    return 0
  fi
  if [ -z "${OBSIDIAN_EXPORT_DIR:-}" ]; then
    echo "[WARN] EXPORT_TO_OBSIDIAN=true but OBSIDIAN_EXPORT_DIR is empty"
    return 0
  fi
  mkdir -p "$OBSIDIAN_EXPORT_DIR/chat"
  if [ -f "$OUTPUT_FILE" ]; then
    cp -f "$OUTPUT_FILE" "$OBSIDIAN_EXPORT_DIR/$(basename "$OUTPUT_FILE")"
  fi
  if [ -d "$OUTPUT_DIR/$DATE" ]; then
    rm -rf "$OBSIDIAN_EXPORT_DIR/$DATE"
    cp -R "$OUTPUT_DIR/$DATE" "$OBSIDIAN_EXPORT_DIR/"
  fi
  if [ -f "$CHAT_FILE" ]; then
    cp -f "$CHAT_FILE" "$OBSIDIAN_EXPORT_DIR/chat/$(basename "$CHAT_FILE")"
  fi
  if [ -d "$CHAT_DIR/$DATE" ]; then
    rm -rf "$OBSIDIAN_EXPORT_DIR/chat/$DATE"
    cp -R "$CHAT_DIR/$DATE" "$OBSIDIAN_EXPORT_DIR/chat/"
  fi
  if [ -f "$OUTPUT_DIR/README.md" ]; then
    cp -f "$OUTPUT_DIR/README.md" "$OBSIDIAN_EXPORT_DIR/README.md"
  fi
  if [ -f "$OUTPUT_DIR/latest.md" ]; then
    cp -f "$OUTPUT_DIR/latest.md" "$OBSIDIAN_EXPORT_DIR/latest.md"
  fi
  echo "[OK] Copied Markdown to $OBSIDIAN_EXPORT_DIR"
}

notify_mobile() {
  local title="$1"
  local message="$2"
  local url="${3:-}"
  local notify_env_file="${NOTIFY_ENV_FILE:-$REPO_DIR/../hf-paper-tracker/.env}"

  uv run scripts/notify_mobile.py \
    --title "$title" \
    --message "$message" \
    --url "$url" \
    --env-file "$notify_env_file" || true
}

stage_if_inside_repo() {
  local path="$1"
  local abs_path
  abs_path="$(cd "$path" 2>/dev/null && pwd)" || return 0
  case "$abs_path" in
    "$REPO_DIR"|"$REPO_DIR"/*) git add "$path" ;;
    *) echo "[WARN] Skip external git add: $abs_path" ;;
  esac
}

pull_latest_if_enabled() {
  if [ "${PUSH_TO_GIT:-true}" != "true" ]; then
    return 0
  fi
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "[WARN] Not inside a git worktree; skip pull"
    return 0
  fi
  local branch
  branch="$(git rev-parse --abbrev-ref HEAD)"
  if [ -z "$branch" ] || [ "$branch" = "HEAD" ]; then
    echo "[WARN] Detached HEAD; skip pull"
    return 0
  fi
  echo "[0/8] Pulling latest origin/$branch..."
  git pull --rebase origin "$branch"
}

push_markdown_outputs() {
  if [ "${PUSH_TO_GIT:-true}" != "true" ]; then
    echo "[SKIP] PUSH_TO_GIT=false"
    return 0
  fi
  stage_if_inside_repo "$OUTPUT_DIR"
  stage_if_inside_repo "$CHAT_DIR"
  if ! git diff --staged --quiet; then
    git commit -m "paperpile brief: $DATE"
    git push
    echo "[OK] Pushed Markdown to remote"
  else
    echo "[SKIP] Nothing to commit"
  fi
}

mkdir -p "$OUTPUT_DIR" "$RAW_DIR" "$PAPER_RAW_DIR" "$CHAT_DIR" "$STATE_DIR" "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=== Paperpile Daily Brief: $DATE $(date +%H:%M:%S) ==="

if [ -z "${PAPERPILE_EXPORT_PATH:-}" ]; then
  echo "[ERROR] PAPERPILE_EXPORT_PATH is not set"
  exit 1
fi

if [ -n "${PAPERPILE_SYNC_SCRIPT:-}" ]; then
  if [ ! -x "$PAPERPILE_SYNC_SCRIPT" ]; then
    echo "[ERROR] PAPERPILE_SYNC_SCRIPT is not executable: $PAPERPILE_SYNC_SCRIPT"
    exit 1
  fi
  echo "[0/6] Syncing Paperpile export..."
  "$PAPERPILE_SYNC_SCRIPT"
fi

pull_latest_if_enabled

if [ -f "$OUTPUT_FILE" ]; then
  echo "[SKIP] $OUTPUT_FILE already exists"
  exit 0
fi

echo "[1/6] Reading Paperpile export..."
uv run scripts/fetch_new_papers.py \
  --export "$PAPERPILE_EXPORT_PATH" \
  --state "$STATE_FILE" \
  --output "$RAW_FILE" \
  --date "$DATE"

PAPER_COUNT="$(uv run python -c "import json; print(json.load(open('$RAW_FILE'))['count'])")"
if [ "$PAPER_COUNT" -eq 0 ]; then
  {
    echo "- $DATE $(date +%H:%M:%S): new_papers=0 source=$PAPERPILE_EXPORT_PATH"
  } >> "$ACTIVITY_LOG"
  uv run scripts/update_index.py --briefs-dir "$OUTPUT_DIR" --chat-dir "$CHAT_DIR"
  copy_to_obsidian
  notify_mobile "Paperpile Brief $DATE" "新しく追加された論文はありません。記録は logs/activity.md に追記しました。"
  echo "[OK] No new papers"
  exit 0
fi

echo "[2/8] Extracting PDF text..."
PDF_ENRICH_ARGS=(--raw "$RAW_FILE")
if [ -n "${PAPERPILE_PDF_BASE_DIR:-}" ]; then
  PDF_ENRICH_ARGS+=(--paperpile-base-dir "$PAPERPILE_PDF_BASE_DIR")
fi
uv run scripts/enrich_pdf_text.py "${PDF_ENRICH_ARGS[@]}"

echo "[3/8] Preparing per-paper brief targets..."
uv run scripts/prepare_paper_briefs.py \
  --raw "$RAW_FILE" \
  --briefs-dir "$OUTPUT_DIR" \
  --chat-dir "$CHAT_DIR" \
  --paper-raw-dir "$PAPER_RAW_DIR" \
  --manifest "$MANIFEST_FILE"

echo "[4/8] Generating per-paper Ochiai-format Markdown with Codex..."
echo "[INFO] codex: $(command -v codex || echo 'not found')"
mapfile -t PAPER_ROWS < <(uv run python -c "import json; m=json.load(open('$MANIFEST_FILE')); [print('\t'.join([p['raw'], p['brief'], p['chat'], p['title'].replace('\t', ' ')])) for p in m['papers']]")
for PAPER_ROW in "${PAPER_ROWS[@]}"; do
  IFS=$'\t' read -r PAPER_RAW PAPER_BRIEF PAPER_CHAT PAPER_TITLE <<< "$PAPER_ROW"
  echo "[INFO] Briefing: $PAPER_TITLE"
  if ! codex exec "
$(cat prompts/ochiai_brief_prompt.md)

日付は ${DATE} です。
入力JSONは ${PAPER_RAW} です。このファイルには1本の論文だけが入っています。
指定フォーマットで、その論文単体のMarkdown本文だけを出力してください。
" -s read-only -o "$PAPER_BRIEF" < /dev/null; then
    echo "[ERROR] Codex analysis failed: $PAPER_TITLE"
    exit 1
  fi

  if [ ! -s "$PAPER_BRIEF" ]; then
    echo "[ERROR] Output Markdown is empty: $PAPER_BRIEF"
    exit 1
  fi

  uv run scripts/create_chat_prompt.py --raw "$PAPER_RAW" --brief "$PAPER_BRIEF" --output "$PAPER_CHAT"

  {
    echo
    echo "---"
    echo
    echo "## 追加で聞く"
    echo
    echo "- Chat prompt: [$(basename "$PAPER_CHAT")](../../chat/$DATE/$(basename "$PAPER_CHAT"))"
    echo "- モバイルではObsidian Mobileで上のchatファイルを開き、本文をChatGPT mobileへ貼る。"
  } >> "$PAPER_BRIEF"
done

echo "[5/8] Writing daily index..."
uv run scripts/write_daily_index.py --manifest "$MANIFEST_FILE" --output "$OUTPUT_FILE"
uv run scripts/update_index.py --briefs-dir "$OUTPUT_DIR" --chat-dir "$CHAT_DIR"

echo "[6/8] Exporting Markdown..."
copy_to_obsidian

echo "[7/8] Commit and push Markdown..."
push_markdown_outputs

echo "[8/8] Marking papers as processed and notifying..."
uv run scripts/mark_processed.py --raw "$RAW_FILE" --state "$STATE_FILE"

notify_mobile "Paperpile Brief $DATE" "新規論文 ${PAPER_COUNT} 本の論文別briefを生成しました。Obsidianの paperpile-briefs/$DATE.md から読めます。"

echo "=== Done: $(date +%H:%M:%S) ==="
