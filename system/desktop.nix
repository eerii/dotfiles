{
  lib,
  config,
  pkgs,
  sys,
  ...
}:
with lib;
let
  scale = if sys.hostname == "vm" then "1" else "2";
in
{
  options = {
    gnome.enable = mkEnableOption "enable gnome";
    sway = {
      enable = mkEnableOption "enable sway";
      resolution = mkOption {
        default = "2560x1600";
        description = "internal display resolution";
      };
      scale = mkOption {
        default = 1.5;
        description = "internal display scale";
      };
    };
  };

  config = mkMerge [
    (mkIf config.gnome.enable {
      services = {
        # Gnome is used as a fallback window manager. It's not required, but it's useful to have
        xserver.desktopManager.gnome = {
          enable = true;
          extraGSettingsOverrides = ''
            [org.gnome.desktop.input-sources]
            sources = [('xkb', 'us+altgr-intl'), ('xkb', 'es')]
            xkb-options = ['ctrl:nocaps']

            [org.gnome.desktop.wm.keybindings]
            close = ['<Super>q']
            [org.gnome.desktop.wm.preferences]
            focus-mode = 'sloppy'
            resize-with-right-button = true

            [org.gnome.desktop.peripherals.keyboard]
            delay = 220
            repeat-interval = 20
            [org.gnome.desktop.peripherals.touchpad]
            tap-to-click = true

            [org.gnome.desktop.interface]
            scaling-factor = ${scale}

            [org.gnome.shell]
            favorite-apps = ['firefox.desktop', 'org.gnome.Nautilus.desktop']
            welcome-dialog-last-shown-version = '9999999999'

            [org.gnome.settings-daemon.plugins.power]
            ambient-enabled = false

            [org.gnome.mutter]
            experimental-features = ['scale-monitor-framebuffer']
          '';
          extraGSettingsOverridePackages = with pkgs.gnome; [
            mutter
            gnome-settings-daemon
          ];
        };
        # Disable all gnome apps (they can be installed with home manager)
        gnome.core-utilities.enable = false;
      };
    })
    (mkIf config.sway.enable {
      # We use swayfx over sway to get the display manager configuration
      programs.sway = {
        enable = true;
        package = pkgs.swayfx;
      };
    })
  ];
}
