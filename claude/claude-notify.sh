#!/usr/bin/env bash
# Claude Code -> macOS desktop notification (terminal-notifier), tmux/kitty aware.
#
# Usage: claude-notify.sh <done|input>   (hook event JSON arrives on stdin)
#
# Wired from ~/.claude/settings.json hooks:
#   Stop         -> claude-notify.sh done
#   Notification -> claude-notify.sh input
#
# Behavior: skips the popup when Claude finishes/needs-input in the tmux pane
# you are currently viewing (attached session + active window + active pane),
# so you only get pinged for background windows. Clicking the notification
# jumps to that tmux window and brings kitty to the front.

set -uo pipefail

event="${1:-done}"
payload="$(cat 2>/dev/null || true)"

# tmux pane Claude is running in (inherited from the parent process env).
pane="${TMUX_PANE:-}"

# --- Suppress when you're already looking at this pane -----------------------
if [ -n "${TMUX:-}" ] && [ -n "$pane" ] && command -v tmux >/dev/null 2>&1; then
  read -r attached win_active pane_active <<EOF
$(tmux display-message -p -t "$pane" '#{session_attached} #{window_active} #{pane_active}' 2>/dev/null)
EOF
  if [ "${attached:-0}" -ge 1 ] 2>/dev/null \
     && [ "${win_active:-0}" = "1" ] \
     && [ "${pane_active:-0}" = "1" ]; then
    exit 0
  fi
fi

# --- Build the message ------------------------------------------------------
where=""
if [ -n "${TMUX:-}" ] && [ -n "$pane" ] && command -v tmux >/dev/null 2>&1; then
  where="$(tmux display-message -p -t "$pane" '#S:#I #W' 2>/dev/null || true)"
fi

msg=""
if command -v jq >/dev/null 2>&1; then
  msg="$(printf '%s' "$payload" | jq -r '.message // empty' 2>/dev/null || true)"
fi

case "$event" in
  input)
    title="Claude needs input"
    body="${msg:-Waiting for your response}"
    ;;
  *)
    title="Claude finished"
    body="${msg:-Turn complete}"
    ;;
esac
[ -n "$where" ] && body="$body — $where"

# --- Fire the notification --------------------------------------------------
if command -v terminal-notifier >/dev/null 2>&1; then
  args=(-title "$title" -message "$body" -sound default -group "claude-${pane:-main}")
  if [ -n "$pane" ]; then
    args+=(-execute "tmux select-window -t '$pane' >/dev/null 2>&1; open -a kitty")
  else
    args+=(-activate "net.kovidgoyal.kitty")
  fi
  terminal-notifier "${args[@]}" >/dev/null 2>&1 || true
else
  # Fallback: no terminal-notifier -> AppleScript (no click action).
  safe_title="${title//\"/}"
  safe_body="${body//\"/}"
  osascript -e "display notification \"$safe_body\" with title \"$safe_title\"" >/dev/null 2>&1 || true
fi

exit 0
