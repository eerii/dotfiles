#!/bin/bash
eww kill

monitors=$(hyprctl monitors -j | jq '.[] | .id')

i=0
for monitor in ${monitors}; do
    eww open bar${i}
    ((i=i+1))
done
