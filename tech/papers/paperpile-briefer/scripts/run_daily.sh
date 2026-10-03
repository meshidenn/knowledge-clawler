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
SLACK_STATE_DIR="$RAW_DIR/$DATE.slack-state"
SLACK_SENT_FILE="$RAW_DIR/$DATE.slack-threads.sent"
EXPORT_STAGE_DIR=""
LOCAL_EXPORT_PATH=""
CURRENT_STEP="startup"

stage_export_locally() {
  local export_name
  local copy_attempt
  local copy_attempts="${PAPERPILE_EXPORT_COPY_ATTEMPTS:-6}"
  local retry_seconds="${PAPERPILE_EXPORT_COPY_RETRY_SECONDS:-30}"

  export_name="$(basename "$PAPERPILE_EXPORT_PATH")"
  EXPORT_STAGE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/paperpile-export.XXXXXX")"
  LOCAL_EXPORT_PATH="$EXPORT_STAGE_DIR/$export_name"
  # Google Drive上のファイルを直接Pythonから読まず、ローカルへ退避してから読む。
  for ((copy_attempt = 1; copy_attempt <= copy_attempts; copy_attempt++)); do
    if cp -f "$PAPERPILE_EXPORT_PATH" "$LOCAL_EXPORT_PATH"; then
      break
    fi
    if [ "$copy_attempt" -lt "$copy_attempts" ]; then
      echo "[WARN] Paperpile export copy failed (attempt ${copy_attempt}/${copy_attempts}); retrying in ${retry_seconds}s"
      sleep "$retry_seconds"
    fi
  done
  if [ ! -s "$LOCAL_EXPORT_PATH" ]; then
    echo "[ERROR] Failed to stage Paperpile export locally: $PAPERPILE_EXPORT_PATH"
    return 1
  fi
  if [ ! -s "$LOCAL_EXPORT_PATH" ]; then
    echo "[ERROR] Staged Paperpile export is empty: $LOCAL_EXPORT_PATH"
    return 1
  fi
  trap 'rm -rf "$EXPORT_STAGE_DIR"' EXIT
  echo "[OK] Staged Paperpile export locally: $LOCAL_EXPORT_PATH"
}

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

notify_failure() {
  local exit_code="$1"
  local hermes_python="${HERMES_PYTHON:-/Users/hiroki-iida/.hermes/hermes-agent/venv/bin/python}"
  local hermes_home="${HERMES_HOME:-/Users/hiroki-iida/personal-ops/.hermes}"
  local slack_target="${PAPERPILE_SLACK_TARGET:-slack:C0C4MDEGSUU}"
  local failure_message

  if [ "$exit_code" -eq 0 ] || [ "${PAPERPILE_SLACK_ENABLED:-true}" != "true" ]; then
    return 0
  fi

  failure_message="⚠️ Paperpile Briefer failed (${DATE})
Step: ${CURRENT_STEP}
Exit code: ${exit_code}
Log: ${LOG_FILE}"
  HERMES_HOME="$hermes_home" "$hermes_python" -m hermes_cli.main send \
    --to "$slack_target" \
    --json \
    "$failure_message" >/dev/null 2>&1 || true
}

build_slack_parent_message() {
  local paper_raw="$1"
  local output_file="$2"

  python3 - "$paper_raw" <<'PY' > "$output_file"
import json
import sys
from urllib.parse import quote

paper = json.load(open(sys.argv[1], encoding="utf-8"))["papers"][0]
title = str(paper.get("title") or "")
authors = paper.get("authors") or []
if isinstance(authors, str):
    authors = [authors]

formatted_authors = []
for author in authors:
    author = str(author).strip()
    if "," in author:
        family, given = [part.strip() for part in author.split(",", 1)]
        author = f"{given} {family}".strip()
    if author:
        formatted_authors.append(author)

url = str(paper.get("url") or "").strip()
doi = str(paper.get("doi") or "").strip()
arxiv_id = str(paper.get("arxiv_id") or "").strip()
if not url and doi:
    url = f"https://doi.org/{doi.removeprefix('doi:')}"
if not url and arxiv_id:
    url = f"https://arxiv.org/abs/{arxiv_id.removeprefix('arXiv:')}"
if not url and "arxiv" in str(paper.get("venue") or "").lower():
    url = "https://arxiv.org/search/?query=" + quote(title) + "&searchtype=title"

print(title)
if formatted_authors:
    print(f"著者: {', '.join(formatted_authors)}")
if url:
    print(f"論文: {url}")
PY
}

notify_slack_threads() {
  local hermes_python="${HERMES_PYTHON:-/Users/hiroki-iida/.hermes/hermes-agent/venv/bin/python}"
  local hermes_home="${HERMES_HOME:-/Users/hiroki-iida/personal-ops/.hermes}"
  local slack_target="${PAPERPILE_SLACK_TARGET:-slack:C0C4MDEGSUU}"
  local paper_key
  local parent_ts
  local parent_result_file
  local reply_result_file

  if [ "${PAPERPILE_SLACK_ENABLED:-true}" != "true" ]; then
    echo "[SKIP] PAPERPILE_SLACK_ENABLED=false"
    return 0
  fi

  mkdir -p "$SLACK_STATE_DIR"
  while IFS=$'\t' read -r paper_raw paper_brief _paper_chat paper_title; do
    paper_key="$(basename "$paper_raw" .json)"
    parent_ts_file="$SLACK_STATE_DIR/$paper_key.parent_ts"
    sent_file="$SLACK_STATE_DIR/$paper_key.sent"
    parent_result_file="$SLACK_STATE_DIR/$paper_key.parent.json"
    reply_result_file="$SLACK_STATE_DIR/$paper_key.reply.json"

    if [ -f "$sent_file" ]; then
      echo "[SKIP] Slack already sent: $paper_title"
      continue
    fi

    if [ -f "$parent_ts_file" ]; then
      parent_ts="$(cat "$parent_ts_file")"
      echo "[RETRY] Sending pending Slack thread reply: $paper_title"
    else
      echo "[INFO] Sending Slack paper title: $paper_title"
      build_slack_parent_message "$paper_raw" "$SLACK_STATE_DIR/$paper_key.title"
      HERMES_HOME="$hermes_home" "$hermes_python" -m hermes_cli.main send \
        --to "$slack_target" \
        --file "$SLACK_STATE_DIR/$paper_key.title" \
        --json > "$parent_result_file"
      parent_ts="$(python3 -c 'import json, sys; print(json.load(open(sys.argv[1])).get("message_id", ""))' "$parent_result_file")"
      if [ -z "$parent_ts" ]; then
        echo "[ERROR] Slack parent message did not return a thread id: $paper_title"
        return 1
      fi
      printf '%s\n' "$parent_ts" > "$parent_ts_file"
    fi

    echo "[INFO] Sending Slack thread summary: $paper_title"
    HERMES_HOME="$hermes_home" "$hermes_python" -m hermes_cli.main send \
      --to "${slack_target}:${parent_ts}" \
      --file "$paper_brief" \
      --json > "$reply_result_file"
    touch "$sent_file"
  done < <(uv run python -c "import json; m=json.load(open('$MANIFEST_FILE')); [print('\\t'.join([p['raw'], p['brief'], p['chat'], p['title'].replace('\\t', ' ')])) for p in m['papers']]")

  touch "$SLACK_SENT_FILE"
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
  git pull --rebase --autostash origin "$branch"
}

push_markdown_outputs() {
  if [ "${PUSH_TO_GIT:-true}" != "true" ]; then
    echo "[SKIP] PUSH_TO_GIT=false"
    return 0
  fi
  stage_if_inside_repo "$OUTPUT_DIR"
  stage_if_inside_repo "$CHAT_DIR"
  stage_if_inside_repo "$LOG_DIR"
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
trap 'exit_code=$?; notify_failure "$exit_code"' EXIT

echo "=== Paperpile Daily Brief: $DATE $(date +%H:%M:%S) ==="

if [ -z "${PAPERPILE_EXPORT_PATH:-}" ]; then
  echo "[ERROR] PAPERPILE_EXPORT_PATH is not set"
  exit 1
fi

if [ -n "${PAPERPILE_SYNC_SCRIPT:-}" ]; then
  CURRENT_STEP="sync_paperpile_export"
  if [ ! -x "$PAPERPILE_SYNC_SCRIPT" ]; then
    echo "[ERROR] PAPERPILE_SYNC_SCRIPT is not executable: $PAPERPILE_SYNC_SCRIPT"
    exit 1
  fi
  echo "[0/6] Syncing Paperpile export..."
  "$PAPERPILE_SYNC_SCRIPT"
fi

pull_latest_if_enabled

if [ -f "$OUTPUT_FILE" ]; then
  if [ -f "$MANIFEST_FILE" ] && [ ! -f "$SLACK_SENT_FILE" ]; then
    echo "[RETRY] Sending pending per-paper Slack updates for $DATE"
    notify_slack_threads
  fi
  echo "[SKIP] $OUTPUT_FILE already exists"
  exit 0
fi

CURRENT_STEP="stage_paperpile_export"
echo "[1/6] Reading Paperpile export..."
stage_export_locally
uv run scripts/fetch_new_papers.py \
  --export "$LOCAL_EXPORT_PATH" \
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
  push_markdown_outputs
  notify_mobile "Paperpile Brief $DATE" "新しく追加された論文はありません。記録は logs/activity.md に追記しました。"
  echo "[OK] No new papers"
  exit 0
fi

echo "[2/8] Extracting PDF text..."
CURRENT_STEP="enrich_pdf_text"
PDF_ENRICH_ARGS=(--raw "$RAW_FILE")
if [ -n "${PAPERPILE_PDF_BASE_DIR:-}" ]; then
  PDF_ENRICH_ARGS+=(--paperpile-base-dir "$PAPERPILE_PDF_BASE_DIR")
fi
uv run scripts/enrich_pdf_text.py "${PDF_ENRICH_ARGS[@]}"

echo "[3/8] Preparing per-paper brief targets..."
CURRENT_STEP="prepare_paper_briefs"
uv run scripts/prepare_paper_briefs.py \
  --raw "$RAW_FILE" \
  --briefs-dir "$OUTPUT_DIR" \
  --chat-dir "$CHAT_DIR" \
  --paper-raw-dir "$PAPER_RAW_DIR" \
  --manifest "$MANIFEST_FILE"

echo "[4/8] Generating per-paper Ochiai-format Markdown with Codex..."
CURRENT_STEP="generate_briefs"
echo "[INFO] codex: $(command -v codex || echo 'not found')"
while IFS=$'\t' read -r PAPER_RAW PAPER_BRIEF PAPER_CHAT PAPER_TITLE; do
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
done < <(uv run python -c "import json; m=json.load(open('$MANIFEST_FILE')); [print('\t'.join([p['raw'], p['brief'], p['chat'], p['title'].replace('\t', ' ')])) for p in m['papers']]")

echo "[5/8] Writing daily index..."
CURRENT_STEP="write_daily_index"
uv run scripts/write_daily_index.py --manifest "$MANIFEST_FILE" --output "$OUTPUT_FILE"
uv run scripts/update_index.py --briefs-dir "$OUTPUT_DIR" --chat-dir "$CHAT_DIR"

echo "[6/8] Exporting Markdown..."
CURRENT_STEP="export_markdown"
copy_to_obsidian

echo "[7/8] Commit and push Markdown..."
CURRENT_STEP="push_markdown_outputs"
push_markdown_outputs

echo "[8/8] Marking papers as processed and notifying..."
CURRENT_STEP="mark_processed_and_notify"
uv run scripts/mark_processed.py --raw "$RAW_FILE" --state "$STATE_FILE"

notify_slack_threads

notify_mobile "Paperpile Brief $DATE" "新規論文 ${PAPER_COUNT} 本の論文別briefを生成しました。GitHub/repoの paperpile-briefer/briefs/$DATE.md から読めます。"

echo "=== Done: $(date +%H:%M:%S) ==="
