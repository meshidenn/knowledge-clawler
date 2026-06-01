# Sourced by run_daily.sh / run_weekly.sh.
# cron のデフォルト PATH には ~/.local/bin や mise shims が入らないため、
# uv / codex / claude が「コマンドが見つかりません」になるのを防ぐ。
export PATH="${HOME}/.local/bin:${HOME}/.local/share/mise/shims:/usr/local/bin:/usr/bin:/bin${PATH:+:$PATH}"

# 生成物の保存先（必要に応じて .env で上書き）
export WORK_DIR="${WORK_DIR:-}"
export LOG_DIR="${LOG_DIR:-}"
export DAILY_OUTPUT_DIR="${DAILY_OUTPUT_DIR:-}"
export DAILY_RAW_DIR="${DAILY_RAW_DIR:-}"
export WEEKLY_OUTPUT_DIR="${WEEKLY_OUTPUT_DIR:-}"

# Obsidian vault へのエクスポート（無効化可能）
export EXPORT_TO_OBSIDIAN="${EXPORT_TO_OBSIDIAN:-false}"
export OBSIDIAN_EXPORT_DAILY_DIR="${OBSIDIAN_EXPORT_DAILY_DIR:-$HOME/Obsidian/intake/hf-papers/daily}"
export OBSIDIAN_EXPORT_WEEKLY_DIR="${OBSIDIAN_EXPORT_WEEKLY_DIR:-$HOME/Obsidian/intake/hf-papers/weekly}"

# 互換用の旧変数名
export OBSIDIAN_HF_PAPERS_DAILY="${OBSIDIAN_HF_PAPERS_DAILY:-$OBSIDIAN_EXPORT_DAILY_DIR}"
export OBSIDIAN_HF_PAPERS_WEEKLY="${OBSIDIAN_HF_PAPERS_WEEKLY:-$OBSIDIAN_EXPORT_WEEKLY_DIR}"
