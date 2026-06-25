#!/bin/bash

# Prints the position of the given session among all sessions, e.g. [2/3].
# Usage: session_index.sh <session_name>

current="$1"
sessions=$(tmux list-sessions -F '#{session_name}')
total=$(printf '%s\n' "$sessions" | grep -c .)
index=$(printf '%s\n' "$sessions" | grep -nxF "$current" | cut -d: -f1)

if [ -n "$index" ]; then
  echo "[$index/$total]"
fi
