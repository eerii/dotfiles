{
  lib,
  pkgs,
  inputs,
  config,
  osConfig,
  ...
}:
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
  config = lib.mkIf config.wayland.enable (
    lib.mkIf osConfig.sway.enable {
      wayland.windowManager.sway =
        let
          mod = "Mod4";
          workspaces = lib.lists.range 0 9;
          jumpToWorkspace = lib.listToAttrs (
            map (v: {
              name = "--no-repeat ${mod}+${toString v}";
              value = ''workspace number ${toString v}; exec "echo 1 > /tmp/sovpipe"'';
            }) workspaces
          );
          releaseWorkspace = lib.listToAttrs (
            map (v: {
              name = "--release ${mod}+${toString v}";
              value = ''exec "echo 0 > /tmp/sovpipe"'';
            }) workspaces
          );
          moveToWorkspace = lib.listToAttrs (
            map (v: {
              name = "${mod}+Shift+${toString v}";
              value = "move container to workspace number ${toString v}";
            }) workspaces
          );
        in
        {
          enable = true;

          # Swayfx, a fork of sway with eye candy
          package = lib.mkIf osConfig.sway.swayfx inputs.swayfx.packages.${pkgs.system}.default;

          config = rec {
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
                  resX = lib.strings.toInt (lib.elemAt (builtins.split "x" osConfig.sway.resolution) 0);
                  scaledResX = lib.elemAt (builtins.split "." (builtins.toString (resX / osConfig.sway.scale))) 0;
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
              { command = "dunst"; }
              { command = "swww-daemon"; }
              { command = "swayosd-server"; }
              { command = "autotiling-rs"; }
              { command = "powerprofilesctl set power-saver"; }
              { command = "wl-paste --type text --watch cliphist store"; }
              { command = "wl-paste --type image --watch cliphist store"; }
              { command = "rm -f /tmp/sovpipe && mkfifo /tmp/sovpipe && tail -f /tmp/sovpipe | sov -t 500"; }
              { command = "firefox --name=firefox-main"; }
              { command = "thunderbird"; }
              { command = "gtk-launch org.gnome.Fractal"; }
              { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
            ];

            bars = [ ]; # Disable swaybar

            defaultWorkspace = "workspace number 2";
            workspaceAutoBackAndForth = true;

            # Graphics
            colors = { };

            window = {
              titlebar = false;
              border = 1;
              commands = [
                {
                  command = "move scratchpad";
                  criteria = {
                    app_id = "org.gnome.Fractal";
                  };
                }
              ];
            };
            floating.border = 1;

            gaps.inner = 8;

            # Input
            input = {
              "type:touchpad" = {
                xkb_layout = "us(altgr-intl),es";
                xkb_options = "ctrl:nocaps";
                repeat_delay = "220";
                repeat_rate = "40";
                tap = "enabled";
                natural_scroll = "enabled";
              };
            };
            seat = {
              "*" = {
                hide_cursor = "3000";
              };
            };

            keybindings = lib.mkMerge [
              jumpToWorkspace
              moveToWorkspace
              releaseWorkspace
              {
                # Applications
                "${mod}+s" = "exec ${terminal}";
                "${mod}+Shift+s" = "exec cool-retro-term";
                "${mod}+w" = "exec firefox";
                "${mod}+a" = "exec nautilus";

                # Launcher

                # Run app
                "${mod}+space" = "exec pkill rofi || rofi -show drun -show-icons | xargs swaymsg exec --";
                # Show clipboard history
                "${mod}+v" = "exec pkill rofi || cliphist list | ${menu} | cliphist decode | wl-copy";

                # Screenshot
                "${mod}+p" = ''exec grim -g "$(slurp)" - | satty -f -'';
                "${mod}+o" = ''exec pkill wl-screenrec || wl-screenrec --codec hevc -f "/home/eri/Videos/Grabaciones/$(date '+%Y-%m-%d@%H:%M:%S').mp4"'';
                "Print" = ''exec grim -g "$(slurp)" - | satty -f -'';

                # System
                "--no-repeat ${mod}+q" = "kill";
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
                "${mod}+r" = ''mode "resize"'';

                "${mod}+minus" = "scratchpad show";
                "${mod}+Shift+minus" = "move scratchpad";

                # Laptop keys
                "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
                "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";

                "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
                "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
                "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";

                "XF86AudioPlay" = "exec playerctl play-pause";
                "XF86AudioNext" = "exec playerctl next";
                "XF86AudioPrev" = "exec playerctl previous";

                "XF86Tools" = "exec";
              }
            ];
          };

          # Extra configuration
          extraConfig = ''
            # Gestures

            bindgesture swipe:right exec ${swayWorkspaces}/bin/swayWorkspaces prev
            bindgesture swipe:left exec ${swayWorkspaces}/bin/swayWorkspaces next

            bindsym ${mod}+m [app_id="org.gnome.Fractal"] scratchpad show

            for_window [app_id=".*"] opacity 0.95

            floating_modifier ${mod} inverse

            output * adaptive_sync on

            ${swayfxConfig}
          '';

          # Temporary fix for swayfx 0.4 / sway 1.9
          checkConfig = false;

          swaynag.enable = true;
        };

      services = {
        # Clipboard history
        cliphist = {
          enable = true;
          systemdTarget = "sway-session.target";
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

        # Screen recording
        wl-screenrec

        # Show desktop
        sov

        # Wallpapers
        swww

        # Volume and brighness indicators
        swayosd
      ];

      # Impermanence
      persistence.dirs = [ ".cache/swww" ];
    }
  );
}
