{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  waybarDunst = pkgs.writeShellScriptBin "waybarDunst" ''
    COUNT=$(dunstctl count waiting)
    ENABLED=󰂚
    DISABLED=󰪑
    if [ $COUNT != 0 ]; then DISABLED="󰪑 $COUNT"; fi
    if dunstctl is-paused | grep -q "false" ; then echo $ENABLED; else echo $DISABLED; fi
  '';
in
{
  config = lib.mkIf osConfig.sway.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          modules-left = [
            "power-profiles-daemon"
            "clock"
            "sway/workspaces"
            "custom/scratchpad"
            # "custom/github"
            # "systemd-failed-units"
          ];
          modules-center = [ ];
          modules-right = [
            "tray"
            "custom/dunst"
            "custom/fans"
            "custom/timer"
            "pulseaudio"
            "network"
            "battery"
          ];
          clock = {
            interval = 60;
            format = "{:%H:%M}";
            max-length = 25;
            on-click = "swaynag -t 'warning' -m 'Exit Sway?' -b 'Exit' 'swaymsg exit' -b 'Reload' 'swaymsg reload'";
          };
          power-profiles-daemon = {
            format = "{icon}";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              performance = "󱐋";
              balanced = "󰌵";
              power-saver = "";
            };
          };
          "sway/workspaces" = {
            format = "{icon}";
            tooltip = false;
            format-icons = {
              "0" = "󰇮";
              "1" = "󰖟";
              urgent = "";
              focused = "";
              default = "";
            };
            persistent-workspaces = {
              "0" = [ ];
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
            };
          };
          "custom/scratchpad" = {
            interval = 3;
            return-type = "json";
            exec = "swaymsg -t get_tree | ${pkgs.jq}/bin/jq --unbuffered --compact-output '(recurse(.nodes[]) | select(.name == \"__i3_scratch\") | .focus) as $scratch_ids | [..  | (.nodes? + .floating_nodes?) // empty | .[] | select(.id |IN($scratch_ids[]))] as $scratch_nodes | if ($scratch_nodes|length) > 1 then { text: \"\\($scratch_nodes | length)\", tooltip: $scratch_nodes | map(\"\\(.app_id // .window_properties.class) (\\(.id)): \\(.name)\") | join(\"\\n\") } else empty end'";
            format = "󱞂 {}";
            on-click = "exec swaymsg 'scratchpad show'";
            on-click-right = "exec swaymsg 'move scratchpad'";
          };
          # "custom/github" = {
          #   format = " {}";
          #   return-type = "json";
          #   interval = 300;
          #   exec = "~/.config/waybar/scripts/github";
          #   on-click = "xdg-open https://github.com/notifications";
          # };
          # systemd-failed-units = {
          #   format = " {nr_failed}";
          #   on-click = "exec foot --app-id=\"foot-ps\" /bin/bash -c \"systemctl list-units --state=failed && systemctl --user list-units --state=failed; read\"";
          # };
          tray = {
            icon-size = 21;
            spacing = 10;
          };
          "custom/dunst" = {
            exec = "${waybarDunst}/bin/waybarDunst";
            on-click = "dunstctl set-paused toggle";
            restart-interval = 5;
          };
          pulseaudio = {
            format = "{icon}";
            format-muted = "󰝟";
            format-tooltip = "{volume}%";
            format-icons = {
              headphone = "";
              default = [
                "󰕿"
                "󰖀"
                "󰕾"
              ];
            };
            on-click = "easyeffects";
            scroll-step = 1;
            ignored-sinks = [ "Easy Effects Sink" ];
          };
          network = {
            interface = "wlp1s0";
            format = "{ifname}";
            format-wifi = "󰤨";
            format-ethernet = "󰈀";
            format-disconnected = "󰤮";
            tooltip-format-wifi = "{essid}";
            tooltip-format-ethernet = "{ipaddr}/{cidr}";
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-icons = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            format-charging = "󰂅 {capacity}%";
            tooltip-format = "{capacity}%";
          };
        };
      };
      style = ''
        * {
          border: none;
          font-family: "Inter", "Symbols Nerd Font Mono";
          font-size: 14px;
        }

        window#waybar {
          background: transparent;
        }

        .modules-right,
        .modules-center,
        .modules-left {
          margin: 8px 8px 0 8px;
          min-height: 32px;
        }

        .modules-right {
          margin: 8px 8px 0 0;
        }

        #workspaces,
        #tray,
        label.module {
          color: #b4befe;
          background-color: #080c10;
          border-radius: 10px;
          padding-left: 10px;
          padding-right: 10px;
        }

        #workspaces button {
          color: #b4befe;
          padding: 6px;
        }

        #power-profiles-daemon,
        #custom-dunst {
          border-radius: 10px 0 0 10px;
          padding-right: 12px;
        }
        #custom-fans,
        #pulseaudio,
        #network {
          border-radius: 0;
          padding: 0 12px 0 0;
        }
        #clock,
        #custom-timer,
        #battery {
          border-radius: 0 10px 10px 0;
          padding-left: 0;
        }

        #clock,
        #custom-arch,
        #workspaces,
        #custom-scratchpad,
        #custom-github,
        #custom-timer,
        #tray {
          margin-right: 8px;
        }
      '';
    };
  };
}
