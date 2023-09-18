#!/bin/bash

function handle {
    if [[ ${1:0:12} == "monitoradded" ]]; then
        ~/.config/hypr/scripts/eww.sh
    elif [[ ${1:0:14} == "monitorremoved" ]]; then
        ~/.config/hypr/scripts/eww.sh
    fi
}

socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
