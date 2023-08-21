{ ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = ''
# Monitor
monitor=eDP-1,2880×1800@60,0x0,1.75

# Launch
exec-once = dunst & waybar & swww init & swww img ~/Pictures/Wallpapers/darkmountains.png

input {
    kb_layout = es
    kb_options = ctrl:nocaps
    follow_mouse = 1
    sensitivity = 0.33
    touchpad {
        natural_scroll = true
        clickfinger_behavior = true
    }
}
exec-once = hyprctl setcursor "Bibata-Modern-Ice" 24

general {
    gaps_in = 5
    gaps_out = 10
    layout = master

    border_size = 2
    col.active_border = rgb(191724) # same as bg
    col.inactive_border = rgb(191724)

    cursor_inactive_timeout = 2
}

decoration {
    rounding = 6

    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Blur rofi
layerrule = blur,rofi

animations {
    enabled = true
    bezier = myBezier, 0.16, 1, 0.3, 1

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, myBezier, popin 80%
    animation = border, 1, 10, myBezier
    animation = fade, 1, 7, myBezier
    animation = workspaces, 1, 5, default
}

master {
    new_on_top = true
}

gestures {
    workspace_swipe = on
}

misc {
    disable_hyprland_logo = true
    suppress_portal_warnings = 1
}

# Bindings
$mainMod = SUPER

bind = $mainMod, T, exec, kitty
bind = $mainMod, B, exec, librewolf
bind = $mainMod, SPACE, exec, pkill rofi || sh ~/.config/rofi/bin/launcher
bind = $mainMod, P, exec, screenshot

bind = $mainMod, Q, killactive
bind = $mainMod SHIFT, Q, exit
bind = $mainMod, D, togglefloating
bind = $mainMod, F, fullscreen

bind = $mainMod, X, exec, wtype -P XF86Cut
bind = $mainMod, C, exec, wtype -P XF86Copy
bind = $mainMod, V, exec, wtype -P XF86Paste

# Master
bind = $mainMod, N, layoutmsg, orientationnext
bind = $mainMod, comma, layoutmsg, addmaster
bind = $mainMod, period, layoutmsg, removemaster
bind = $mainMod, RETURN, layoutmsg, swapwithmaster

# System
bind = , xf86audioraisevolume, exec, amixer sset Master 5%+
bind = , xf86audiolowervolume, exec, amixer sset Master 5%-

bind = , xf86monbrightnessup, exec, brightnessctl set 5%+
bind = , xf86monbrightnessdown, exec, brightnessctl set 5%-

# Movement
bind = $mainMod, l, movefocus, l
bind = $mainMod, h, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

bindm = $mainMod, mouse:272, movewindow
bindm = CTRL, mouse:272, resizewindow
        '';
    };
}
