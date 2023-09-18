#!/bin/zsh

# Rclone mode: copy (default) or sync
RCLONE_MODE=copy
if [[ $# > 0 && "$1" = "--sync" ]]; then
  RCLONE_MODE=sync
  shift
fi

# Chech that in and out parameters are passed
if [[ $# < 2 ]]; then
    echo "Usage: rc [--sync] <in> <out> [extra]"
    exit
fi

rclone copy -P -l -M -u -v $1 $2 \
    --stats 5s \
    --exclude .git/ \
    --exclude .DS_Store \
    --exclude "**/.**.icloud" \
    --exclude node_modules/ \
    --exclude .next/ \
    --exclude .cache/ \
    --exclude .ipynb_checkpoints/ --exclude "**pygtex" --exclude "**synctex**" \
    --exclude .cmake/ --exclude CMakeFiles/ \
    --exclude .gradle/ \
    --exclude "**.scriv/" \
    --checkers 16 \
    --user-agent "ISV|rclone.org|rclone/v1.55.1" \
    ${@:3}
