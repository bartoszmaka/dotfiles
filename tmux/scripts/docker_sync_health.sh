#!/usr/bin/env bash
# docker-sync health indicator for tmux.
#
# Writes the current epoch to a sentinel file on the host and reads it back
# inside the container; if the value lags by more than DOCKER_SYNC_MAX_LAG
# seconds (or the container isn't reachable) the sync is considered broken.
#
# The probe runs in the background and writes "ok" / "fail" / "bind" /
# "unknown" to a cache file; tmux's status-right call just prints the cached
# value, so the status redraw stays fast even though `docker exec` is slow.
#
# "bind" means the container mounts the synced dir straight from the host
# instead of from a synced volume, so no sync is in play at all -- the lag
# probe cannot detect this on its own because both paths are the same file.
#
# The committed defaults below are generic placeholders. To point the probe at
# your real project/container, create a gitignored file next to this script
# named `docker_sync_health.local.sh` that sets any of the vars below, e.g.:
#     DOCKER_SYNC_HOST_DIR="$HOME/projects/foo"
#     DOCKER_SYNC_CONTAINER="foo-web-1"
#     DOCKER_SYNC_CONTAINER_DIR="/opt/foo"
#     DOCKER_SYNC_LABEL="foo"
# A local file is sourced instead of your shell rc because tmux runs status
# commands via /bin/sh, which does NOT source ~/.zshrc or ~/.zsh_secrets.
#
# Vars (with generic defaults):
#   DOCKER_SYNC_HOST_DIR        host dir that is synced            (~/projects/app)
#   DOCKER_SYNC_CONTAINER       container to exec into             (my-container)
#   DOCKER_SYNC_CONTAINER_DIR   matching path inside the container (/opt/app)
#   DOCKER_SYNC_LABEL           label shown in the status line     (sync)
#   DOCKER_SYNC_MAX_LAG         max acceptable lag in seconds      (10)
#   DOCKER_SYNC_ACTIVE_PATH_GLOB  if set, indicator is hidden when the pane path
#                                 (passed as $1) does not match this glob
#
# Usage:
#   docker_sync_health.sh [pane_current_path]

set -u

# Load local (gitignored) overrides sitting next to this script, if present.
# tmux invokes this via ~/.tmux/scripts/... (a symlink into the dotfiles repo),
# so the override lands in the repo dir and must be gitignored.
_dir="$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=/dev/null
[[ -f "$_dir/docker_sync_health.local.sh" ]] && source "$_dir/docker_sync_health.local.sh"

HOST_DIR="${DOCKER_SYNC_HOST_DIR:-$HOME/projects/app}"
CONTAINER="${DOCKER_SYNC_CONTAINER:-my-container}"
CONTAINER_DIR="${DOCKER_SYNC_CONTAINER_DIR:-/opt/app}"
MAX_LAG="${DOCKER_SYNC_MAX_LAG:-10}"
LABEL="${DOCKER_SYNC_LABEL:-sync}"
ACTIVE_PATH_GLOB="${DOCKER_SYNC_ACTIVE_PATH_GLOB:-}"
PANE_PATH="${1:-}"

if [[ -n "$ACTIVE_PATH_GLOB" ]]; then
  if [[ -z "$PANE_PATH" ]] || [[ ! "$PANE_PATH" == $ACTIVE_PATH_GLOB ]]; then
    exit 0
  fi
fi

PROBE_REL="tmp/.docker-sync-probe"
HOST_PROBE="$HOST_DIR/$PROBE_REL"
CONTAINER_PROBE="$CONTAINER_DIR/$PROBE_REL"

CACHE="/tmp/docker-sync-health.${CONTAINER}.cache"
LOCK="/tmp/docker-sync-health.${CONTAINER}.lock"

COLOR_OK="#8bcd5b"
COLOR_FAIL="#f65866"
COLOR_UNKNOWN="#f2cc81"

now=$(date +%s)
lock_mtime=$(stat -f %m "$LOCK" 2>/dev/null || echo 0)

if (( now - lock_mtime > 4 )); then
  : > "$LOCK"
  (
    if [[ ! -d "$HOST_DIR/tmp" ]]; then
      echo "unknown" > "$CACHE"
      exit 0
    fi
    # A bind mount makes host and container paths the same file, so the lag
    # probe below is trivially satisfied and would report "ok" even with no
    # sync running at all. Detect that case explicitly.
    mount_type=$(timeout 2 docker inspect "$CONTAINER" \
      --format "{{range .Mounts}}{{if eq .Destination \"$CONTAINER_DIR\"}}{{.Type}}{{end}}{{end}}" \
      2>/dev/null | tr -dc a-z)
    if [[ "$mount_type" == "bind" ]]; then
      echo "bind" > "$CACHE"
      exit 0
    fi

    probe_now=$(date +%s)
    if ! echo "$probe_now" > "$HOST_PROBE" 2>/dev/null; then
      echo "fail" > "$CACHE"
      exit 0
    fi
    seen=$(timeout 2 docker exec "$CONTAINER" cat "$CONTAINER_PROBE" 2>/dev/null | tr -dc 0-9)
    if [[ -z "$seen" ]]; then
      echo "fail" > "$CACHE"
      exit 0
    fi
    if (( probe_now - seen <= MAX_LAG )); then
      echo "ok" > "$CACHE"
    else
      echo "fail" > "$CACHE"
    fi
  ) >/dev/null 2>&1 &
  disown 2>/dev/null || true
fi

state=$(cat "$CACHE" 2>/dev/null || echo "unknown")
case "$state" in
  ok)   printf '#[fg=%s]%s ✓#[default]' "$COLOR_OK" "$LABEL" ;;
  fail) printf '#[fg=%s]%s ✗#[default]' "$COLOR_FAIL" "$LABEL" ;;
  bind) printf '#[fg=%s]%s bind#[default]' "$COLOR_UNKNOWN" "$LABEL" ;;
  *)    printf '#[fg=%s]%s ?#[default]' "$COLOR_UNKNOWN" "$LABEL" ;;
esac
