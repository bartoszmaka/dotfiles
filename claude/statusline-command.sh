#!/usr/bin/env bash
# Claude Code status line script
# Receives JSON on stdin with session data

input=$(cat)

# ANSI color codes
RESET=$'\e[0m'
BOLD=$'\e[1m'
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
CYAN=$'\e[36m'
BRIGHT_RED=$'\e[91m'
BRIGHT_GREEN=$'\e[92m'
BRIGHT_CYAN=$'\e[96m'
BRIGHT_MAGENTA=$'\e[95m'
GRAY=$'\e[90m'

# Color text based on percentage: green <50%, yellow 50-75%, red 75-90%, bold bright-red >=90%
color_by_pct() {
  local pct=$1 text=$2
  if [ -z "$pct" ]; then printf '%s' "$text"; return; fi
  local rounded
  rounded=$(printf "%.0f" "$pct")
  if [ "$rounded" -ge 90 ]; then
    printf '%s' "${BOLD}${BRIGHT_RED}${text}${RESET}"
  elif [ "$rounded" -ge 75 ]; then
    printf '%s' "${RED}${text}${RESET}"
  elif [ "$rounded" -ge 50 ]; then
    printf '%s' "${YELLOW}${text}${RESET}"
  else
    printf '%s' "${GREEN}${text}${RESET}"
  fi
}

# Color model name: Opus = bold bright-magenta, Sonnet = bright-cyan, Haiku = bright-green
color_model() {
  local m=$1 lower
  lower=$(echo "$m" | tr '[:upper:]' '[:lower:]')
  if echo "$lower" | grep -q "opus"; then
    printf '%s' "${BOLD}${BRIGHT_MAGENTA}${m}${RESET}"
  elif echo "$lower" | grep -q "sonnet"; then
    printf '%s' "${BRIGHT_CYAN}${m}${RESET}"
  elif echo "$lower" | grep -q "haiku"; then
    printf '%s' "${BRIGHT_GREEN}${m}${RESET}"
  else
    printf '%s' "$m"
  fi
}

model=$(echo "$input" | jq -r '.model.display_name // "unknown model"')

# Context window fields
tokens_used=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
window_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Rate limit fields
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Session duration in seconds
duration_secs=$(echo "$input" | jq -r 'if .cost.total_duration_ms then (.cost.total_duration_ms / 1000 | floor) else empty end')

# Compaction count from transcript
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
compaction_count=""
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  _cmp_raw=$(grep -c '"type":"compactResult"' "$transcript_path" 2>/dev/null || echo "0")
  _cmp=$(printf '%s' "$_cmp_raw" | tr -d '[:space:]')
  [ "$_cmp" -gt 0 ] 2>/dev/null && compaction_count="$_cmp"
fi

# Format integer as compact number with k/M suffix
short_num() {
  local n
  n=$(printf "%.0f" "$1")
  if [ "$n" -ge 1000000 ]; then
    printf "%.1fM" "$(echo "scale=1; $n / 1000000" | bc)"
  elif [ "$n" -ge 1000 ]; then
    printf "%.0fk" "$(echo "scale=0; $n / 1000" | bc)"
  else
    echo "$n"
  fi
}

# Format seconds as [Xd ]HH:MM:SS
fmt_duration() {
  local s=$1
  local d=$(( s / 86400 )) h=$(( (s % 86400) / 3600 )) m=$(( (s % 3600) / 60 )) sec=$(( s % 60 ))
  if [ "$d" -gt 0 ]; then
    printf "%dd %02d:%02d:%02d" "$d" "$h" "$m" "$sec"
  else
    printf "%02d:%02d:%02d" "$h" "$m" "$sec"
  fi
}

# Format seconds until unix timestamp reset as [Xd ]HH:MM
fmt_till_reset() {
  local reset=$1 now diff d h m
  now=$(date +%s)
  diff=$(( reset - now ))
  if [ "$diff" -le 0 ]; then echo "now"; return; fi
  d=$(( diff / 86400 )) h=$(( (diff % 86400) / 3600 )) m=$(( (diff % 3600) / 60 ))
  if [ "$d" -gt 0 ]; then
    printf "%dd %02d:%02d" "$d" "$h" "$m"
  else
    printf "%02d:%02d" "$h" "$m"
  fi
}

# Context segment — always shown when window_size is known
ctx_segment=""
if [ -n "$window_size" ]; then
  w=$(short_num "$window_size")
  if [ -n "$tokens_used" ] && [ -n "$used_pct" ]; then
    t=$(short_num "$tokens_used")
    value=$(printf "%s / %s (%.0f%%)" "$t" "$w" "$used_pct")
    ctx_segment="${GRAY}ctx: ${RESET}$(color_by_pct "$used_pct" "$value")"
  else
    ctx_segment="${GRAY}ctx: ${RESET}${GREEN}0 / ${w} (0%)${RESET}"
  fi
elif [ -n "$used_pct" ]; then
  value=$(printf "%.0f%%" "$used_pct")
  ctx_segment="${GRAY}ctx: ${RESET}$(color_by_pct "$used_pct" "$value")"
fi
# Append compaction count inline when present
if [ -n "$compaction_count" ] && [ -n "$ctx_segment" ]; then
  ctx_segment="${ctx_segment} ${GRAY}cmp: ${RESET}${compaction_count}"
elif [ -n "$compaction_count" ]; then
  ctx_segment="${GRAY}cmp: ${RESET}${compaction_count}"
fi

# Rate limit segments
rate_segment=""
five_part="" seven_part=""
if [ -n "$five_hour_pct" ]; then
  pct_colored=$(color_by_pct "$five_hour_pct" "$(printf "%.0f%%" "$five_hour_pct")")
  if [ -n "$five_hour_reset" ]; then
    five_part="${GRAY}5h: ${RESET}${pct_colored} ${GRAY}$(fmt_till_reset "$five_hour_reset")${RESET}"
  else
    five_part="${GRAY}5h: ${RESET}${pct_colored}"
  fi
fi
if [ -n "$seven_day_pct" ]; then
  pct_colored=$(color_by_pct "$seven_day_pct" "$(printf "%.0f%%" "$seven_day_pct")")
  if [ -n "$seven_day_reset" ]; then
    seven_part="${GRAY}7d: ${RESET}${pct_colored} ${GRAY}$(fmt_till_reset "$seven_day_reset")${RESET}"
  else
    seven_part="${GRAY}7d: ${RESET}${pct_colored}"
  fi
fi
if [ -n "$five_part" ] && [ -n "$seven_part" ]; then
  rate_segment="${five_part}  ${seven_part}"
elif [ -n "$five_part" ]; then
  rate_segment="$five_part"
elif [ -n "$seven_part" ]; then
  rate_segment="$seven_part"
fi

# Git diff segment
git_segment=""
if git rev-parse --git-dir > /dev/null 2>&1; then
  stat=$(git diff HEAD --shortstat 2>/dev/null)
  if [ -n "$stat" ]; then
    files=$(echo "$stat" | grep -oE '[0-9]+ file' | grep -oE '[0-9]+')
    added=$(echo "$stat" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
    deleted=$(echo "$stat" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')
    git_segment="${GRAY}git: ${RESET}${GREEN}+${added:-0}${RESET} ${RED}-${deleted:-0}${RESET} ${GRAY}(${files:-0} files)${RESET}"
  fi
fi

# Session duration segment
duration_segment=""
if [ -n "$duration_secs" ]; then
  duration_segment="${GRAY}session: ${RESET}$(fmt_duration "$duration_secs")"
fi

# Assemble final line
model_part=$(color_model "$model")
parts=("$model_part")
[ -n "$ctx_segment" ]      && parts+=("$ctx_segment")
[ -n "$rate_segment" ]     && parts+=("$rate_segment")
[ -n "$git_segment" ]      && parts+=("$git_segment")
[ -n "$duration_segment" ] && parts+=("$duration_segment")

output=""
for part in "${parts[@]}"; do
  [ -z "$output" ] && output="$part" || output="${output}  |  ${part}"
done

printf '%s\n' "$output"
