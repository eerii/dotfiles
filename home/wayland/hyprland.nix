{ ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        extraConfig = ''

# Monitor
monitor=,preferred,auto,auto

# Launch
exec-once = waybar

# Environment
env = XCURSOR_SIZE,24

input {
    kb_layout = es
    kb_variant = mac
    follow_mouse = 1
    touchpad {
        natural_scroll = false
    }
    sensitivity = 0
}

general {
    gaps_in = 5
    gaps_out = 20
    layout = dwindle
}

decoration {
    rounding = 10
    blur = true
    blur_size = 3
    blur_passes = 1
    blur_new_optimizations = true
    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    pseudotile = true
    preserve_split = true
}

# Bindings
$mainMod = SUPER

bind = $mainMod, T, exec, kitty
bind = $mainMod, C, killactive,
bind = $mainMod, Q, exit,

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

bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
        '';
    };
}
