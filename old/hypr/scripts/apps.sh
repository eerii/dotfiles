#!/bin/bash

dunst &
udiskie &
darkman &

nohup beeper --hidden --no-sandbox --default-frame --enable-features=UseOzonePlatform --ozone-platform=wayland %U
nohup easyeffects --gapplication-service &
