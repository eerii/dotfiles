#!/bin/bash

dunst &
udiskie &
darkman &

beeper --hidden --no-sandbox --default-frame --enable-features=UseOzonePlatform --ozone-platform=wayland %U
easyeffects --gapplication-service &
