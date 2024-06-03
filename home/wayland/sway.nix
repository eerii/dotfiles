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

        output * adaptive_sync on
      ''
    else
      "";

  swayWorkspaces = pkgs.writeShellScriptBin "swayWorkspaces" ''
    ACTIVE_WS=$(swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq --raw-output 'map(select(.focused == true)) | .[0].name' | awk '{print $1}')
    MAX_WS=$(swaymsg -t get_workspaces | ${pkgs.jq}/bin/jq --raw-output 'map(select(.representation)) | max_by (.num) | .num' | awk '{print $1}')

    if [ "$1" = "window" ]; then
    	CMD="swaymsg move window to workspace"
    	shift
    else
    	CMD="swaymsg workspace number"
    fi

    if [ "$1" = "next" ]; then
    	test $ACTIVE_WS -gt $MAX_WS && exit 1
    	$CMD $((ACTIVE_WS + 1))
    elif [ "$1" = "prev" ]; then
    	test $ACTIVE_WS -eq 0 && exit 1
    	$CMD $((ACTIVE_WS - 1))
    fi
  '';
in
{
  config = mkIf config.wayland.enable (
    mkIf osConfig.sway.enable {
      wayland.windowManager.sway =
        let
          mod = "Mod4";
          workspaces = lists.range 0 9;
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
        {
          enable = true;

          # Swayfx, a fork of sway with eye candy
          package = mkIf osConfig.sway.swayfx inputs.swayfx.packages.${pkgs.system}.default;

          config = rec {
            # Global settings
            modifier = mod;
            floating.modifier = mod;
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
              "0" = [ { app_id = "thunderbird"; } ];
              "1" = [ { app_id = "firefox-main"; } ];
            };

            startup = [
              { command = "waybar"; }
              { command = "swww-daemon"; }
              { command = "dunst"; }
              { command = "autotiling-rs"; }
              { command = "wl-paste --type text --watch cliphist store"; }
              { command = "wl-paste --type image --watch cliphist store"; }
              { command = "firefox --name=firefox-main"; }
              { command = "thunderbird"; }
              { command = "gtk-launch org.gnome.Fractal"; }
              { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
            ];

            bars = [ ]; # Disable swaybar

            defaultWorkspace = "workspace number 2";
            workspaceAutoBackAndForth = true;
            # workspaceOutputAssign = [];

            # Graphics
            colors = { };

            window = {
              titlebar = false;
              border = 0;
              commands = [
                {
                  command = "move scratchpad";
                  criteria = {
                    app_id = "org.gnome.Fractal";
                  };
                }
              ];
            };
            floating.border = 0;

            gaps.inner = 8;

            # Input
            input = {
              "*" = {
                xkb_layout = "us,es";
                xkb_variant = "altgr-intl";
                xkb_options = "ctrl:nocaps";
                repeat_delay = "220";
                repeat_rate = "40";
                tap = "enabled";
                drag = "enabled";
                natural_scroll = "enabled";
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
                  exec swaynag -t "warning" -m "Exit Sway?" -b "Exit" "swaymsg exit" -b "Reload" "swaymsg reload"
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

                "${mod}+left" = "exec ${swayWorkspaces}/bin/swayWorkspaces prev";
                "${mod}+right" = "exec ${swayWorkspaces}/bin/swayWorkspaces next";

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

            bindgesture swipe:right exec ${swayWorkspaces}/bin/swayWorkspaces prev
            bindgesture swipe:left exec ${swayWorkspaces}/bin/swayWorkspaces next

            bindsym ${mod}+m [app_id="org.gnome.Fractal"] scratchpad show

            ${swayfxConfig}
          '';

          # Temporary fix for swayfx 0.4 / sway 1.9
          checkConfig = false;

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
      services = {
        cliphist = {
          enable = true;
          systemdTarget = "sway-session.target";
        };
        gnome-keyring = {
          enable = true;
          components = [ "secrets" ];
        };
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

        # Wallpapers
        swww
      ];

      # Impermanence
      persistence.dirs = [ ".cache/swww" ];
    }
  );
}
