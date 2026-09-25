#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
LABEL="com.knowledge-clawler.paperpile-briefer"
AGENT_DIR="$HOME/Library/LaunchAgents"
PLIST_PATH="$AGENT_DIR/$LABEL.plist"
UID_VALUE="$(id -u)"
PAPERPILE_EXPORT_PATH="${PAPERPILE_EXPORT_PATH:-}"
PUSH_TO_GIT="${PUSH_TO_GIT:-false}"

if [ -z "$PAPERPILE_EXPORT_PATH" ] || [ ! -f "$PAPERPILE_EXPORT_PATH" ]; then
  echo "[ERROR] Set PAPERPILE_EXPORT_PATH to an existing export file" >&2
  exit 1
fi

mkdir -p "$AGENT_DIR" "$REPO_DIR/logs"
cat > "$PLIST_PATH" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$LABEL</string>
  <key>WorkingDirectory</key><string>$REPO_DIR</string>
  <key>ProgramArguments</key>
  <array><string>/bin/bash</string><string>$REPO_DIR/scripts/run_daily.sh</string></array>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PAPERPILE_EXPORT_PATH</key><string>$PAPERPILE_EXPORT_PATH</string>
    <key>PUSH_TO_GIT</key><string>$PUSH_TO_GIT</string>
  </dict>
  <key>StartCalendarInterval</key>
  <dict><key>Hour</key><integer>4</integer><key>Minute</key><integer>30</integer></dict>
  <key>StandardOutPath</key><string>$REPO_DIR/logs/launchd.stdout.log</string>
  <key>StandardErrorPath</key><string>$REPO_DIR/logs/launchd.stderr.log</string>
</dict>
</plist>
EOF

plutil -lint "$PLIST_PATH"
launchctl bootout "gui/$UID_VALUE/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$UID_VALUE" "$PLIST_PATH"
launchctl print "gui/$UID_VALUE/$LABEL" >/dev/null
echo "[OK] Installed $LABEL at 04:30"
