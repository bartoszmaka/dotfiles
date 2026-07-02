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
effort=$(echo "$input" | jq -r '.effort.level // empty')

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

# Current working directory segment (~-abbreviated path)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
dir_segment=""
if [ -n "$cwd" ]; then
  dir_disp="$cwd"
  case "$dir_disp" in
    "$HOME")   dir_disp="~" ;;
    "$HOME"/*) dir_disp="~${dir_disp#"$HOME"}" ;;
  esac
  dir_segment="${GRAY}dir: ${RESET}${CYAN}${dir_disp}${RESET}"
fi

# Account / subscription segment — read from Claude Code's oauthAccount.
# The statusline JSON carries no account info, so we read the config file directly.
acct_segment=""
account_config=""
if [ -n "$CLAUDE_CONFIG_DIR" ] && [ -f "$CLAUDE_CONFIG_DIR/.claude.json" ]; then
  account_config="$CLAUDE_CONFIG_DIR/.claude.json"
elif [ -f "$HOME/.claude.json" ]; then
  account_config="$HOME/.claude.json"
fi
if [ -n "$account_config" ]; then
  acct_email=$(jq -r '.oauthAccount.emailAddress // empty' "$account_config" 2>/dev/null)
  if [ -n "$acct_email" ]; then
    # The email→label mapping lives in a gitignored sibling file so real
    # addresses stay out of the repo. Resolve this script's real directory
    # (following symlinks) to find it, then source it if present. It should
    # define acct_label_for(): given an email, echo a short label.
    # See statusline-accounts.local.sh.example for the format.
    _src="${BASH_SOURCE[0]:-$0}"
    while [ -h "$_src" ]; do
      _dir=$(cd -P "$(dirname "$_src")" >/dev/null 2>&1 && pwd)
      _src=$(readlink "$_src")
      case "$_src" in /*) ;; *) _src="$_dir/$_src" ;; esac
    done
    script_dir=$(cd -P "$(dirname "$_src")" >/dev/null 2>&1 && pwd)
    accounts_file="$script_dir/statusline-accounts.local.sh"

    acct_label=""
    if [ -f "$accounts_file" ]; then
      # shellcheck source=/dev/null
      . "$accounts_file"
      if command -v acct_label_for >/dev/null 2>&1; then
        acct_label=$(acct_label_for "$acct_email")
      fi
    fi
    # Fallback with no hardcoded addresses: use the email's local-part.
    [ -z "$acct_label" ] && acct_label="${acct_email%@*}"

    # Color by label (non-secret, safe to keep in the repo).
    case "$acct_label" in
      work)     acct_color="${BOLD}${YELLOW}" ;;
      personal) acct_color="${GREEN}" ;;
      *)        acct_color="${CYAN}" ;;
    esac
    acct_segment="${GRAY}acct: ${RESET}${acct_color}${acct_label}${RESET}"
  fi
fi

# Session duration segment
duration_segment=""
if [ -n "$duration_secs" ]; then
  duration_segment="${GRAY}session: ${RESET}$(fmt_duration "$duration_secs")"
fi

# Assemble final line
model_part=$(color_model "$model")
[ -n "$effort" ] && model_part="${model_part} ${GRAY}[${effort}]${RESET}"
parts=("$model_part")
[ -n "$ctx_segment" ]      && parts+=("$ctx_segment")
[ -n "$rate_segment" ]     && parts+=("$rate_segment")
[ -n "$git_segment" ]      && parts+=("$git_segment")
[ -n "$duration_segment" ] && parts+=("$duration_segment")
[ -n "$acct_segment" ]     && parts+=("$acct_segment")
[ -n "$dir_segment" ]      && parts+=("$dir_segment")

# Visible length of a string, ignoring ANSI color escapes.
vlen() {
  local s=$1 re=$'\e\\[[0-9;]*m'
  while [[ $s =~ $re ]]; do s=${s/"${BASH_REMATCH[0]}"/}; done
  printf '%s' "${#s}"
}

# Assemble into rows. Claude Code provides the terminal width in $COLUMNS; when
# the full line wouldn't fit, greedy-wrap segments onto extra rows so the status
# line spans multiple lines instead of being truncated on narrow windows.
sep="  |  "
cols="${COLUMNS:-0}"
case "$cols" in ''|*[!0-9]*) cols=0 ;; esac

if [ "$cols" -gt 0 ]; then
  output="" line="" line_len=0
  for part in "${parts[@]}"; do
    plen=$(vlen "$part")
    if [ -z "$line" ]; then
      line="$part"; line_len=$plen
    elif [ $(( line_len + ${#sep} + plen )) -le "$cols" ]; then
      line="${line}${sep}${part}"; line_len=$(( line_len + ${#sep} + plen ))
    else
      output="${output}${line}"$'\n'
      line="$part"; line_len=$plen
    fi
  done
  output="${output}${line}"
else
  output=""
  for part in "${parts[@]}"; do
    [ -z "$output" ] && output="$part" || output="${output}${sep}${part}"
  done
fi

printf '%s\n' "$output"
