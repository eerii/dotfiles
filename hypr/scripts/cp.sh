#!/bin/bash

win=$(hyprctl activewindow | grep class | awk '{print $NF}')

# Wezterm handles itself except for undo
if [[ $win == 'org.wezfurlong.wezterm' ]]; then
    if [[ $1 == 'z' ]]; then
        wtype -M ctrl -M shift $1 -m shift -m ctrl
    else
        wtype -M logo $1 -m logo
    fi
    exit
fi

# The rest is mapped to ctrl
wtype -M ctrl $1 -m ctrl
