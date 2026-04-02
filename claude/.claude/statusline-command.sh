#!/usr/bin/env bash
# Claude Code status line — inspired by agnoster zsh theme
# Receives JSON via stdin

input=$(cat)

# --- Data extraction ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Short directory: replace $HOME with ~, then show only last 2 components
if [ -n "$cwd" ]; then
  short_dir="${cwd/#$HOME/\~}"
  # Keep only last 2 path segments (agnoster-style)
  short_dir=$(echo "$short_dir" | awk -F'/' '{
    n=NF
    if (n<=2) print $0
    else if ($1=="~") {
      if (n==3) print "~/" $(n)
      else print "~/../" $(n)
    } else print "../" $(n)
  }')
fi

# Git branch (skip optional lock to avoid blocking)
git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
               || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Context usage bar
ctx_part=""
if [ -n "$used_pct" ]; then
  ctx_int=$(printf "%.0f" "$used_pct")
  ctx_part=" ctx:${ctx_int}%"
fi

# Rate limits (5-hour) when available
rate_part=""
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
if [ -n "$five_pct" ]; then
  five_int=$(printf "%.0f" "$five_pct")
  rate_part=" 5h:${five_int}%"
fi

# --- Assemble output with ANSI colors (will be dimmed by Claude Code) ---
# Agnoster palette: dir=blue bold, git=yellow, model=cyan, ctx=green/red
dir_color="\033[1;34m"   # bold blue
git_color="\033[0;33m"   # yellow
model_color="\033[0;36m" # cyan
ctx_color="\033[0;32m"   # green
reset="\033[0m"

out=""

if [ -n "$short_dir" ]; then
  out="${out}${dir_color}${short_dir}${reset}"
fi

if [ -n "$git_branch" ]; then
  out="${out} ${git_color}[${git_branch}]${reset}"
fi

if [ -n "$model" ]; then
  out="${out} ${model_color}${model}${reset}"
fi

if [ -n "$ctx_part" ]; then
  out="${out}${ctx_color}${ctx_part}${reset}"
fi

if [ -n "$rate_part" ]; then
  out="${out}${ctx_color}${rate_part}${reset}"
fi

printf "%b" "$out"
