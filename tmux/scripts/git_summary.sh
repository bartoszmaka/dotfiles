#!/bin/bash

if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  branch=$(git rev-parse --abbrev-ref HEAD)
  stats=$(git diff --shortstat | sed -E 's/[^0-9]*([0-9]+) file.* ([0-9]+) insertion.* ([0-9]+) delet.*/ 󰈙 \1  \2  \3/')
  echo " $branch $stats "
fi
