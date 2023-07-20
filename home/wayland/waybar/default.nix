{ pkgs, inputs, ... }:
{
    programs.waybar = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
        settings = [{
            layer = "top";
            modules-left = ["custom/nix" "wlr/workspaces"];
            modules-center = ["clock"];
            modules-right = ["backlight" "pulseaudio" "temperature" "bluetooth" "network" "battery"];

            # Left
            "custom/nix" = {
                format = "  ";
                tooltip = false;
                on-click = "sh $HOME/.config/rofi/bin/powermenu";
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
                format = "<span color='#b4befe'> </span>{:%H:%M}";
            };

            # Right
            backlight = {
                device = "intel_backlight";
                format = "<span color='#b4befe'>{icon}</span> {percent}%";
                format-icons = ["" "" "" "" "" "" "" "" ""];
            };
            pulseaudio = {
                format = "<span color='#b4befe'>{icon}</span> {volume}%";
                format-muted = "";
                tooltip = false;
                format-icons = {
                    headphone = "";
                    default = ["" "" "󰕾" "󰕾" "󰕾" "" "" ""];
                };
                scroll-step = 1;
            };
            temperature = {
                tooltip = false;
                format = " {temperatureC}°C";
            };
            bluetooth = {
                format = "<span color='#b4befe'></span> {status}";
                format-disabled = "";
                format-connected = "<span color='#b4befe'></span> {num_connections}";
                tooltip-format = "{device_enumerate}";
                tooltip-format-enumerate-connected = "{device_alias}   {device_address}";
            };
            network = {
                interface = "wlo1";
                format = "{ifname}";
                format-wifi = "<span color='#b4befe'> </span>{essid}";
                format-ethernet = "{ipaddr}/{cidr} ";
                format-disconnected = "<span color='#b4befe'>󰖪 </span>No Network";
                tooltip = false;
            };
            battery = {
                format = "<span color='#b4befe'>{icon}</span> {capacity}%";
                format-icons = ["" "" "" "" "" "" "" "" "" ""];
                format-charging = "<span color='#b4befe'></span> {capacity}%";
                tooltip = false;
            };
        }];
        style = builtins.readFile ./style.css;
    };
}
