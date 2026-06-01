#!/bin/bash
set -euo pipefail

# ============================================
# HF Paper Tracker - 日次インテーク
# cron から呼び出されるエントリポイント
# ============================================

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

DATE=$(date +%Y-%m-%d)
WORK_DIR="${WORK_DIR:-$REPO_DIR/papers}"
LOG_DIR="${LOG_DIR:-$REPO_DIR/logs}"
DAILY_OUTPUT_DIR="${DAILY_OUTPUT_DIR:-$WORK_DIR/daily}"
DAILY_RAW_DIR="${DAILY_RAW_DIR:-$WORK_DIR/daily/raw}"
WEEKLY_OUTPUT_DIR="${WEEKLY_OUTPUT_DIR:-$WORK_DIR/weekly}"

RAW_FILE="${DAILY_RAW_DIR}/${DATE}.json"
OUTPUT_FILE="${DAILY_OUTPUT_DIR}/${DATE}.md"
LOG_FILE="${LOG_DIR}/${DATE}.log"

copy_daily_to_obsidian() {
    if [ "${EXPORT_TO_OBSIDIAN:-false}" != "true" ]; then
        echo "[SKIP] EXPORT_TO_OBSIDIAN is disabled"
        return 0
    fi

    if [ -z "${OBSIDIAN_EXPORT_DAILY_DIR:-}" ]; then
        echo "[SKIP] OBSIDIAN_EXPORT_DAILY_DIR is not set"
        return 0
    fi

    mkdir -p "$OBSIDIAN_EXPORT_DAILY_DIR"
    cp -f "$OUTPUT_FILE" "$OBSIDIAN_EXPORT_DAILY_DIR/$(basename "$OUTPUT_FILE")"
    echo "[OK] Copied to $OBSIDIAN_EXPORT_DAILY_DIR/$(basename "$OUTPUT_FILE")"
}

stage_dir_if_within_repo() {
    local dir="$1"
    local abs_dir

    abs_dir="$(cd "$dir" 2>/dev/null && pwd)" || {
        echo "[WARN] Cannot resolve directory for git add: $dir"
        return 0
    }

    case "$abs_dir" in
        "$REPO_DIR"|"$REPO_DIR"/*)
            git add "$dir"
            ;;
        *)
            echo "[WARN] Skip git add for external directory: $abs_dir"
            ;;
    esac
}

mkdir -p "$DAILY_RAW_DIR" "$DAILY_OUTPUT_DIR" "$WEEKLY_OUTPUT_DIR" "$LOG_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1
echo "=== Daily Intake: $DATE $(date +%H:%M:%S) ==="

# --- Step 1: 既に実行済みならスキップ ---
if [ -f "$OUTPUT_FILE" ]; then
    echo "[SKIP] $OUTPUT_FILE already exists"
    exit 0
fi

# --- Step 2: HF API からデータ取得 ---
echo "[1/6] Fetching papers..."
if ! uv run scripts/fetch_papers.py; then
    echo "[INFO] No papers today — sending notification email"
    echo "# 📭 ${DATE} — 今日のHF Daily Papersはありませんでした" > "$OUTPUT_FILE"
    uv run scripts/send_email.py "$OUTPUT_FILE"
    copy_daily_to_obsidian
    exit 0
fi

if [ ! -f "$RAW_FILE" ]; then
    echo "[ERROR] Failed to fetch papers"
    exit 1
fi

PAPER_COUNT=$(uv run python -c "import json; print(json.load(open('$RAW_FILE'))['count'])")
echo "[OK] Fetched $PAPER_COUNT papers"

# --- Step 3: OpenAI Codex で分析 ---
echo "[2/6] Analyzing with OpenAI Codex..."

if ! codex exec "
${RAW_FILE} を読んで日次インテークを実行してください。
CLAUDE.md の「日次インテーク」セクションのフォーマットに厳密に従い、
最終回答は完成した Markdown 本文のみを返してください。
進捗説明、前置き、補足、コードフェンス、\`@papers/...\` のような参照表記は一切含めないでください。
出力の先頭行は必ず \`# 📅 ${DATE} Daily Papers インテーク\` から始めてください。
" -s read-only -o "$OUTPUT_FILE" >/dev/null 2>&1; then
    echo "[ERROR] Analysis failed"
    exit 1
fi

if [ ! -f "$OUTPUT_FILE" ] || [ ! -s "$OUTPUT_FILE" ]; then
    echo "[ERROR] Analysis failed"
    exit 1
fi

echo "[OK] Saved to $OUTPUT_FILE"

# --- Step 3b: スキップ論文に arXiv リンクを付与（raw JSON と突き合わせ・本文 URL 済みは除外） ---
echo "[3/6] Enriching skip section with arXiv links..."
uv run scripts/enrich_skip_links.py "$OUTPUT_FILE" "$RAW_FILE"

# --- Step 4: メール送信 ---
echo "[4/6] Sending email..."
uv run scripts/send_email.py "$OUTPUT_FILE"

# --- Step 5: Git コミット & プッシュ ---
echo "[5/6] Committing..."
stage_dir_if_within_repo "$WORK_DIR"
if ! git diff --staged --quiet; then
    git commit -m "📄 ${DATE} daily intake"
    git push
    echo "[OK] Pushed to remote"
else
    echo "[SKIP] Nothing to commit"
fi

echo "[6/6] Copying to Obsidian..."
copy_daily_to_obsidian

echo "=== Done: $(date +%H:%M:%S) ==="
