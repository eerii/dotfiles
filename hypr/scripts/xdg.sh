#!/bin/bash

sleep 1

killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal-gnome
killall xdg-desktop-portal
#killall wireplumber
#killall pipewire
#killall pipewire-pulse

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

#/usr/bin/pipewire &
#/usr/bin/pipewire-pulse &
#/usr/bin/wireplumber &

sleep 1

/usr/lib/xdg-desktop-portal-hyprland &

sleep 2

/usr/lib/xdg-desktop-portal &
