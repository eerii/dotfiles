{
  lib,
  pkgs,
  inputs,
  config,
  osConfig,
  ...
}:
with lib;
with builtins;
let
  swayfxConfig =
    if osConfig.sway.swayfx then
      ''
        # Swayfx

        corner_radius 10

        blur enable
        blur_passes 5
        blur_radius 3

        shadows enable
        shadows_on_csd enable
        shadow_blur_radius 3
        shadow_color #bc83e35F

        scratchpad_minimize enable
      ''
    else
      "";
in
{
  config = mkIf config.wayland.enable (
    mkIf osConfig.sway.enable {
      wayland.windowManager.sway = {
        enable = true;

        # Swayfx, a fork of sway with eye candy
        package = mkIf osConfig.sway.swayfx inputs.swayfx.packages.${pkgs.system}.default;

        config =
          let
            mod = "Mod4";
            workspaces = lists.range 1 9;
            jumpToWorkspace = listToAttrs (
              map (v: {
                name = "${mod}+${toString v}";
                value = "workspace number ${toString v}";
              }) workspaces
            );
            moveToWorkspace = listToAttrs (
              map (v: {
                name = "${mod}+Shift+${toString v}";
                value = "move container to workspace number ${toString v}";
              }) workspaces
            );
          in
          rec {
            # Global settings
            modifier = mod;
            terminal = "foot";
            menu = "rofi -dmenu";

            left = "h";
            down = "j";
            up = "k";
            right = "l";

            # Monitors
            output = {
              # Internal monitor
              "eDP-1" = {
                resolution = osConfig.sway.resolution;
                scale = toString osConfig.sway.scale;
                position = "0,0";
              };
              # External monitor
              "DP-1" =
                let
                  resX = strings.toInt (elemAt (split "x" osConfig.sway.resolution) 0);
                  scaledResX = elemAt (split "." (toString (resX / osConfig.sway.scale))) 0;
                in
                {
                  resolution = "3840x2160";
                  scale = "1.25";
                  position = "${scaledResX},0";
                };
            };

            # Logic
            assigns = {
              "0: email" = [ { app_id = "thunderbird"; } ];
              "1: web" = [ { app_id = "firefox-main"; } ];
            };

            startup = [
              # { command = "waybar"; }
              # { command = "swww init"; }
              # { command = "gtk-launch ..."; }
              { command = "autotiling-rs"; }
              { command = "wl-paste --type text --watch cliphist store"; }
              { command = "wl-paste --type image --watch cliphist store"; }
              { command = "firefox --name=firefox-main"; }
              { command = "thunderbird"; }
            ];

            bars = [ ]; # Disable swaybar

            defaultWorkspace = "workspace number 2";
            workspaceAutoBackAndForth = true;
            # workspaceOutputAssign = [];

            # Graphics
            colors = {
              # TODO: Colors
            };

            window.border = 0;
            floating.border = 0;

            gaps.inner = 8;

            # Input
            input = {
              "*" = {
                xkb_layout = "es";
                xkb_options = "ctrl:nocaps";
                repeat_delay = "220";
                repeat_rate = "40";
              };
            };
            seat = {
              "*" = {
                hide_cursor = "3000";
              };
            };

            keybindings = mkMerge [
              jumpToWorkspace
              moveToWorkspace
              {
                # Applications
                "${mod}+t" = "exec ${terminal}";
                "${mod}+Shift+t" = "exec cool-retro-term";
                "${mod}+b" = "exec firefox";
                "${mod}+a" = "exec nautilus";

                # Launcher

                # Run app
                "${mod}+space" = "exec pkill rofi || rofi -show drun -show-icons | xargs swaymsg exec --";
                # Open directory
                "Ctrl+space" = ''exec pkill rofi || ${terminal} -D "$(zoxide query --list | ${menu})"'';
                # Show clipboard history
                "${mod}+v" = "exec pkill rofi || cliphist list | ${menu} | cliphist decode | wl-copy";

                # Utils
                "${mod}+Shift+s" = # Screenshot
                  ''exec grim -g "$(slurp)" - | satty -f -'';

                # System
                "${mod}+q" = "kill";
                "${mod}+Shift+c" = "reload";
                "${mod}+Shift+q" = ''
                  exec swaynagmode -t "warning" -m "Exit Sway?" -b "Exit" "swaymsg exit" -b "Reload" "swaymsg reload"
                '';

                # Movements
                "${mod}+${left}" = "focus left";
                "${mod}+${down}" = "focus down";
                "${mod}+${up}" = "focus up";
                "${mod}+${right}" = "focus right";

                "${mod}+Shift+${left}" = "move left";
                "${mod}+Shift+${down}" = "move down";
                "${mod}+Shift+${up}" = "move up";
                "${mod}+Shift+${right}" = "move right";

                "${mod}+left" = "workspace prev_on_output";
                "${mod}+right" = "workspace next_on_output";

                "${mod}+Shift+left" = "move workspace to output left";
                "${mod}+Shift+right" = "move workspace to output right";

                # Windows
                "${mod}+comma" = "splith";
                "${mod}+period" = "splitv";

                "${mod}+f" = "fullscreen";
                "${mod}+d" = "floating toggle";

                "${mod}+minus" = "scratchpad show";
                "${mod}+Shift+minus" = "move scratchpad";

                # Laptop keys
                "XF86MonBrightnessDown" = "exec light -U 5";
                "XF86MonBrightnessUp" = "exec light -A 5";

                "XF86AudioRaiseVolume" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
                "XF86AudioLowerVolume" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0";
                "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

                "XF86AudioPlay" = "exec playerctl play-pause";
                "XF86AudioNext" = "exec playerctl next";
                "XF86AudioPrev" = "exec playerctl previous";
              }
            ];
          };

        # Extra configuration
        extraConfig = ''
          # Gestures

          bindgesture swipe:right workspace prev_on_output
          bindgesture swipe:left workspace next_on_output

          ${swayfxConfig}
        '';

        # Environment

        extraSessionCommands = ''
          export SDL_VIDEODRIVER=wayland
          export QT_QPA_PLATFORM=wayland
          export QT_QPA_PLATFORMTHEME=gtk2
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          export _JAVA_AWT_WM_NONREPARENTING=1
        '';

        swaynag.enable = true;
      };

      # Clipboard history
      services.cliphist = {
        enable = true;
        systemdTarget = "sway-session.target";
      };

      home.packages = with pkgs; [
        # Autotiling script
        autotiling-rs

        # Clipboard
        wl-clipboard

        # Screenshots
        grim
        slurp
        satty
      ];
    }
  );
}
