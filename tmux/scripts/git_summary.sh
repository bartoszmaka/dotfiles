#!/bin/bash

# Run against the path of the currently active pane (passed by tmux), so the
# summary follows you as you switch panes/windows instead of being stuck in the
# directory tmux was started from.
path="$1"
[ -n "$path" ] && cd "$path" 2>/dev/null || exit 0

if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  branch=$(git rev-parse --abbrev-ref HEAD)

  # Truncate long branch names, keeping the start and end, eliding the middle.
  max=24   # only truncate names longer than this
  head=18  # chars to keep from the beginning
  tail=5   # chars to keep from the end
  if [ "${#branch}" -gt "$max" ]; then
    branch="${branch:0:head}…${branch: -tail}"
  fi

  stats=$(git diff --shortstat | sed -E 's/[^0-9]*([0-9]+) file.* ([0-9]+) insertion.* ([0-9]+) delet.*/ 󰈙 \1  \2  \3/')
  echo " $branch $stats "
fi
