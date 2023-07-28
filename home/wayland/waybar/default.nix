{ pkgs, inputs, ... }:
{
    programs.waybar = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
        settings = [{
            layer = "top";
            modules-left = ["custom/nix" "wlr/workspaces"];
            modules-center = ["clock"];
            modules-right = ["backlight" "pulseaudio" "temperature" "network" "battery"];

            # Left
            "custom/nix" = {
                format = "  ";
                tooltip = false;
                on-click = "sh ~/.config/rofi/bin/powermenu";
            };
            "wlr/workspaces" = {
                format = "{icon}";
                tooltip = false;
                all-outputs = true;
                format-icons = {
                    active = "";
                    default = "";
                };
            };

            # Center
            clock = {
                format = " {:%H:%M}";
            };

            # Right
            backlight = {
                device = "intel_backlight";
                format = "{icon}{percent}%";
                format-icons = ["" "" "" "" "" "" "" "" ""];
            };
            pulseaudio = {
                format = "{icon}{volume}%";
                format-muted = "";
                tooltip = false;
                format-icons = {
                    headphone = "";
                    default = ["" "" "" "" "󰕾" "󰕾" "󰕾" "󰕾"];
                };
                scroll-step = 1;
            };
            temperature = {
                tooltip = false;
                format = "{temperatureC}°C";
            };
            network = {
                interface = "wlp3s0";
                format-wifi = "";
                format-ethernet = "󰈀";
                format-disconnected = "󰖪";
            };
            bluetooth = {
                format-disabled = "󰂲";
                format-connected = "󰂰";
                tooltip-format = "{device_enumerate}";
                tooltip-format-enumerate-connected = "{device_alias}   {device_address}";
            };
            battery = {
                format = "{icon} {capacity}%";
                format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                format-charging = "󰂄{capacity}%";
                tooltip = false;
            };
        }];
        style = builtins.readFile ./style.css;
    };
}
