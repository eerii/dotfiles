#!/usr/bin/env bash

ACTIVE_WS=$(swaymsg -t get_workspaces | jq --raw-output 'map(select(.focused == true)) | .[0].name' | awk '{print $1}')
MAX_WS=$(swaymsg -t get_workspaces | jq --raw-output 'map(select(.representation)) | max_by (.num) | .num' | awk '{print $1}')

if [ "$1" = "window" ]; then
    CMD="swaymsg move window to workspace"
    shift
else
    CMD="swaymsg workspace number"
fi

if [ "$1" = "next" ]; then
    test $ACTIVE_WS -gt $MAX_WS && exit 1
    $CMD $((ACTIVE_WS + 1))
elif [ "$1" = "prev" ]; then
    test $ACTIVE_WS -eq 0 && exit 1
    $CMD $((ACTIVE_WS - 1))
fi
