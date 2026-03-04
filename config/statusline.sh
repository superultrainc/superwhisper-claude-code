#!/bin/bash
# Superwhisper status line for Claude Code
# Install to: ~/.claude/statusline.sh

input=$(cat)
MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')

# Context usage meter (10 chars with eighth-block precision)
PERCENT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
PERCENT=${PERCENT:-0}
((PERCENT > 100)) && PERCENT=100
((PERCENT < 0)) && PERCENT=0

BLOCKS=("" "▏" "▎" "▍" "▌" "▋" "▊" "▉" "█")
BAR=""
FILL=$((PERCENT * 10 / 100))  # full blocks (0-10)
REMAINDER=$(((PERCENT * 10 % 100) * 8 / 100))  # eighth for partial (0-8)

for ((i=0; i<FILL; i++)); do BAR+="█"; done
((FILL < 10)) && BAR+="${BLOCKS[$REMAINDER]}"
EMPTY=$((10 - FILL - (REMAINDER > 0 ? 1 : 0)))
for ((i=0; i<EMPTY; i++)); do BAR+="░"; done

CONTEXT="$BAR $PERCENT%"

# Git info
BRANCH=$(git branch --show-current 2>/dev/null)
GIT_INFO=""
if [ -n "$BRANCH" ]; then
    GIT_INFO="$BRANCH"

    # Get diff stats (+/-)
    STATS=$(git diff --shortstat 2>/dev/null)
    if [ -n "$STATS" ]; then
        ADDS=$(echo "$STATS" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
        DELS=$(echo "$STATS" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')
        [ -n "$ADDS" ] || ADDS="0"
        [ -n "$DELS" ] || DELS="0"
        [ "$ADDS" != "0" ] || [ "$DELS" != "0" ] && GIT_INFO="$GIT_INFO | +$ADDS/-$DELS"
    fi
fi

# Time with am/pm
TIME=$(date +"%I:%M %p")

# Superwhisper status (env var overrides UserDefaults)
if pgrep -f "DerivedData.*superwhisper.app" >/dev/null 2>&1; then
    SW_BUNDLE="com.superduper.superwhisper.debug"
else
    SW_BUNDLE="com.superduper.superwhisper"
fi

if [ "$SUPERWHISPER_AGENT" = "1" ]; then
    SW="✓ superwhisper"
elif [ "$SUPERWHISPER_AGENT" = "0" ]; then
    SW="✗ superwhisper"
elif defaults read "$SW_BUNDLE" agentIntegrationEnabled 2>/dev/null | grep -q 1; then
    SW="✓ superwhisper"
else
    SW="✗ superwhisper"
fi

echo "[$MODEL] ${DIR##*/}${GIT_INFO:+ | $GIT_INFO} | $CONTEXT | $SW | $TIME"
