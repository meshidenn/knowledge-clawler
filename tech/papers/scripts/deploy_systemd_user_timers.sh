#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

install_project_timer() {
  local project_dir="$1"
  local installer="$ROOT_DIR/$project_dir/scripts/install_systemd_user_timer.sh"

  if [ ! -x "$installer" ]; then
    echo "[ERROR] Missing executable installer: $installer" >&2
    return 1
  fi

  echo "[INFO] Installing timers for $project_dir"
  (
    cd "$ROOT_DIR/$project_dir"
    "$installer"
  )
}

command -v systemctl >/dev/null || {
  echo "[ERROR] systemctl is not available" >&2
  exit 1
}

systemctl --user show-environment >/dev/null

install_project_timer "paperpile-briefer"
install_project_timer "hf-paper-tracker"

echo
echo "[OK] Deployed tech/papers systemd user timers"
systemctl --user list-timers 'paperpile*' 'hf-paper-tracker*' --all

if command -v loginctl >/dev/null; then
  linger="$(loginctl show-user "$USER" -p Linger --value 2>/dev/null || true)"
  if [ "$linger" != "yes" ]; then
    echo
    echo "[WARN] User lingering is not enabled. On a headless server, run:"
    echo "       loginctl enable-linger $USER"
  fi
fi
