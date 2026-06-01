#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
UNIT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

mkdir -p "$UNIT_DIR"

cat > "$UNIT_DIR/hf-paper-tracker-daily.service" <<EOF
[Unit]
Description=HF Paper Tracker daily intake

[Service]
Type=oneshot
WorkingDirectory=$REPO_DIR
ExecStart=/bin/bash scripts/run_daily.sh
EOF

cat > "$UNIT_DIR/hf-paper-tracker-daily.timer" <<EOF
[Unit]
Description=Run HF Paper Tracker daily intake on weekdays

[Timer]
OnCalendar=Mon..Fri 09:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

cat > "$UNIT_DIR/hf-paper-tracker-weekly.service" <<EOF
[Unit]
Description=HF Paper Tracker weekly trend analysis

[Service]
Type=oneshot
WorkingDirectory=$REPO_DIR
ExecStart=/bin/bash scripts/run_weekly.sh
EOF

cat > "$UNIT_DIR/hf-paper-tracker-weekly.timer" <<EOF
[Unit]
Description=Run HF Paper Tracker weekly trend analysis

[Timer]
OnCalendar=Sun 10:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now hf-paper-tracker-daily.timer hf-paper-tracker-weekly.timer
systemctl --user list-timers hf-paper-tracker-daily.timer hf-paper-tracker-weekly.timer
