# AGENTS.md

This directory contains automated paper-intake jobs under `tech/papers`.

## Automation Rule

- Use **systemd user timers** for scheduled jobs under this directory.
- Do not add new cron entries for `tech/papers` jobs. Cron may appear in old notes, but systemd is the canonical scheduler here.
- Each project should provide `scripts/install_systemd_user_timer.sh` when it has scheduled automation.
- Timer/service units should live in `~/.config/systemd/user/` and should run the project-local shell entrypoints.
- Use `scripts/cron_env.sh` or an equivalent project-local env bootstrap from those entrypoints so systemd has the same CLI `PATH` as an interactive shell.

## Current Schedules

- `paperpile-briefer`: `paperpile-briefer.timer`, daily at `04:30`.
- `hf-paper-tracker`: `hf-paper-tracker-daily.timer`, Monday-Friday at `09:00`.
- `hf-paper-tracker`: `hf-paper-tracker-weekly.timer`, Sunday at `10:00`.

## Operations

Install or refresh all units:

```bash
cd /home/hiroki/work/knowledge/tech/papers
./scripts/deploy_systemd_user_timers.sh
```

This is the canonical deployment command after moving to a new server. It regenerates the unit files with the current checkout path and enables the timers.

Check schedules and logs:

```bash
systemctl --user list-timers 'paperpile*' 'hf-paper-tracker*'
systemctl --user status paperpile-briefer.service hf-paper-tracker-daily.service hf-paper-tracker-weekly.service
journalctl --user -u paperpile-briefer.service -u hf-paper-tracker-daily.service -u hf-paper-tracker-weekly.service --no-pager
```

Manual runs should still call the same entrypoints used by systemd:

```bash
cd /home/hiroki/work/knowledge/tech/papers/paperpile-briefer
./scripts/run_daily.sh

cd /home/hiroki/work/knowledge/tech/papers/hf-paper-tracker
./scripts/run_daily.sh
./scripts/run_weekly.sh
```
