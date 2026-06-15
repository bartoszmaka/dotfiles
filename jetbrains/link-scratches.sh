#!/usr/bin/env bash
#
# Keep JetBrains (RubyMine) scratch files in iCloud, shared with other editors.
#
# Canonical store lives in iCloud Drive. This script (re)points every RubyMine
# config dir's `scratches` folder at it via symlink, plus a stable ~/scratches
# for Neovim/VS Code/etc. Idempotent — safe to re-run, especially after a
# RubyMine major upgrade creates a fresh config dir (e.g. RubyMine2026.2).
#
# QUIT RUBYMINE before running.

set -euo pipefail

ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/scratches"
JETBRAINS="$HOME/Library/Application Support/JetBrains"

link_to_icloud() {
  # $1 = path that should become a symlink -> $ICLOUD
  local target="$1"

  # Already correctly linked?
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$ICLOUD" ]; then
    echo "ok    $target"
    return
  fi

  # A stale symlink (points elsewhere) — replace it.
  if [ -L "$target" ]; then
    rm "$target"
    ln -s "$ICLOUD" "$target"
    echo "fixed $target"
    return
  fi

  # A real directory with files.
  if [ -d "$target" ]; then
    if [ -d "$ICLOUD" ] && [ -n "$(ls -A "$ICLOUD" 2>/dev/null)" ]; then
      echo "WARN  $target is a real dir but $ICLOUD already has content." >&2
      echo "      Not touching it to avoid data loss — merge manually." >&2
      return
    fi
    # iCloud is missing or an empty placeholder — clear it and move the real files in.
    [ -d "$ICLOUD" ] && rmdir "$ICLOUD"
    mv "$target" "$ICLOUD"
    ln -s "$ICLOUD" "$target"
    echo "moved $target -> iCloud, linked"
    return
  fi

  # Nothing there (or a stray file) — just link.
  [ -e "$target" ] && { echo "WARN  $target exists and is not a dir/symlink, skipping" >&2; return; }
  ln -s "$ICLOUD" "$target"
  echo "link  $target"
}

# Ensure the canonical store exists (first run with nothing to migrate).
mkdir -p "$ICLOUD"

# Every installed RubyMine config dir.
shopt -s nullglob
found=0
for dir in "$JETBRAINS"/RubyMine*; do
  [ -d "$dir" ] || continue
  found=1
  link_to_icloud "$dir/scratches"
done
[ "$found" -eq 0 ] && echo "note  no RubyMine config dirs found under $JETBRAINS"

# Stable path for other editors.
link_to_icloud "$HOME/scratches"

echo "done  canonical store: $ICLOUD"
