#!/usr/bin/env bash
# docker-sync health indicator for tmux.
#
# Writes the current epoch to a sentinel file on the host and reads it back
# inside the container; if the value lags by more than DOCKER_SYNC_MAX_LAG
# seconds (or the container isn't reachable) the sync is considered broken.
#
# The probe runs in the background and writes "ok" / "fail" / "unknown" to a
# cache file; tmux's status-right call just prints the cached value, so the
# status redraw stays fast even though `docker exec` is slow.
#
# Override via env (defaults target the h2 project):
#   DOCKER_SYNC_HOST_DIR        host dir that is synced            (~/projects/work/h2)
#   DOCKER_SYNC_CONTAINER       container to exec into             (container)
#   DOCKER_SYNC_CONTAINER_DIR   matching path inside the container (/opt/work)
#   DOCKER_SYNC_MAX_LAG         max acceptable lag in seconds      (10)
#   DOCKER_SYNC_ACTIVE_PATH_GLOB  if set, indicator is hidden when the pane path
#                                 (passed as $1) does not match this glob
#
# Usage:
#   docker_sync_health.sh [pane_current_path]

set -u

HOST_DIR="${DOCKER_SYNC_HOST_DIR:-$HOME/projects/work/h2}"
CONTAINER="${DOCKER_SYNC_CONTAINER:-container}"
CONTAINER_DIR="${DOCKER_SYNC_CONTAINER_DIR:-/opt/work}"
MAX_LAG="${DOCKER_SYNC_MAX_LAG:-10}"
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
  ok)   printf '#[fg=%s]h2 sync ✓#[default]' "$COLOR_OK" ;;
  fail) printf '#[fg=%s]h2 sync ✗#[default]' "$COLOR_FAIL" ;;
  *)    printf '#[fg=%s]h2 sync ?#[default]' "$COLOR_UNKNOWN" ;;
esac
