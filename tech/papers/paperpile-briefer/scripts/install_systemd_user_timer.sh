#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
UNIT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

mkdir -p "$UNIT_DIR"

cat > "$UNIT_DIR/paperpile-briefer.service" <<EOF
[Unit]
Description=Paperpile daily Ochiai-format brief

[Service]
Type=oneshot
WorkingDirectory=$REPO_DIR
ExecStart=/bin/bash scripts/run_daily.sh
EOF

cat > "$UNIT_DIR/paperpile-briefer.timer" <<EOF
[Unit]
Description=Run Paperpile briefer every day at 04:30

[Timer]
OnCalendar=*-*-* 04:30
Persistent=true

[Install]
WantedBy=timers.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now paperpile-briefer.timer
systemctl --user list-timers paperpile-briefer.timer
