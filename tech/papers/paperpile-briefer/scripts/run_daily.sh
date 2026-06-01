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

DATE="$(date +%Y-%m-%d)"
OUTPUT_DIR="${OUTPUT_DIR:-$REPO_DIR/briefs}"
RAW_DIR="${RAW_DIR:-$REPO_DIR/raw}"
CHAT_DIR="${CHAT_DIR:-$REPO_DIR/chat}"
STATE_DIR="${STATE_DIR:-$REPO_DIR/state}"
LOG_DIR="${LOG_DIR:-$REPO_DIR/logs}"
STATE_FILE="$STATE_DIR/seen.json"
RAW_FILE="$RAW_DIR/$DATE.json"
OUTPUT_FILE="$OUTPUT_DIR/$DATE.md"
CHAT_FILE="$CHAT_DIR/$DATE.md"
LOG_FILE="$LOG_DIR/$DATE.log"

copy_to_obsidian() {
  if [ "${EXPORT_TO_OBSIDIAN:-false}" != "true" ]; then
    return 0
  fi
  if [ -z "${OBSIDIAN_EXPORT_DIR:-}" ]; then
    echo "[WARN] EXPORT_TO_OBSIDIAN=true but OBSIDIAN_EXPORT_DIR is empty"
    return 0
  fi
  mkdir -p "$OBSIDIAN_EXPORT_DIR/chat"
  cp -f "$OUTPUT_FILE" "$OBSIDIAN_EXPORT_DIR/$(basename "$OUTPUT_FILE")"
  cp -f "$CHAT_FILE" "$OBSIDIAN_EXPORT_DIR/chat/$(basename "$CHAT_FILE")"
  if [ -f "$OUTPUT_DIR/README.md" ]; then
    cp -f "$OUTPUT_DIR/README.md" "$OBSIDIAN_EXPORT_DIR/README.md"
  fi
  if [ -f "$OUTPUT_DIR/latest.md" ]; then
    cp -f "$OUTPUT_DIR/latest.md" "$OBSIDIAN_EXPORT_DIR/latest.md"
  fi
  echo "[OK] Copied Markdown to $OBSIDIAN_EXPORT_DIR"
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

mkdir -p "$OUTPUT_DIR" "$RAW_DIR" "$CHAT_DIR" "$STATE_DIR" "$LOG_DIR"
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
  echo "# Paperpile Daily Brief $DATE" > "$OUTPUT_FILE"
  {
    echo
    echo "新しく追加された論文はありません。"
  } >> "$OUTPUT_FILE"
  uv run scripts/create_chat_prompt.py --raw "$RAW_FILE" --brief "$OUTPUT_FILE" --output "$CHAT_FILE"
  uv run scripts/update_index.py --briefs-dir "$OUTPUT_DIR" --chat-dir "$CHAT_DIR"
  copy_to_obsidian
  echo "[OK] No new papers"
  exit 0
fi

echo "[2/6] Generating Ochiai-format Markdown with Codex..."
echo "[INFO] codex: $(command -v codex || echo 'not found')"
if ! codex exec "
$(cat prompts/ochiai_brief_prompt.md)

日付は ${DATE} です。
入力JSONは ${RAW_FILE} です。このファイルを読み、指定フォーマットでMarkdown本文だけを出力してください。
" -s read-only -o "$OUTPUT_FILE"; then
  echo "[ERROR] Codex analysis failed"
  exit 1
fi

if [ ! -s "$OUTPUT_FILE" ]; then
  echo "[ERROR] Output Markdown is empty"
  exit 1
fi

echo "[3/6] Creating chat prompt..."
uv run scripts/create_chat_prompt.py --raw "$RAW_FILE" --brief "$OUTPUT_FILE" --output "$CHAT_FILE"

{
  echo
  echo "---"
  echo
  echo "## 追加で聞く"
  echo
  echo "- このままチャットで聞くためのプロンプト: [chat/$DATE.md](../chat/$DATE.md)"
  echo "- ローカルで続けて聞く例: \`codex exec \"chat/$DATE.md を読んで、気になる点を深掘りして\"\`"
} >> "$OUTPUT_FILE"

uv run scripts/update_index.py --briefs-dir "$OUTPUT_DIR" --chat-dir "$CHAT_DIR"

echo "[4/6] Marking papers as processed..."
uv run scripts/mark_processed.py --raw "$RAW_FILE" --state "$STATE_FILE"

echo "[5/6] Exporting Markdown..."
copy_to_obsidian

echo "[6/6] Commit and push..."
if [ "${PUSH_TO_GIT:-true}" = "true" ]; then
  stage_if_inside_repo "$OUTPUT_DIR"
  stage_if_inside_repo "$CHAT_DIR"
  if ! git diff --staged --quiet; then
    git commit -m "paperpile brief: $DATE"
    git push
    echo "[OK] Pushed to remote"
  else
    echo "[SKIP] Nothing to commit"
  fi
else
  echo "[SKIP] PUSH_TO_GIT=false"
fi

echo "=== Done: $(date +%H:%M:%S) ==="
