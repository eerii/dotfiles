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
  options.gnome.enable = mkEnableOption "enable gnome";

  config = mkIf config.gnome.enable {
    services = {
      # Gnome is used as a fallback window manager. It's not required, but it's useful to have
      xserver.desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
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

          [org.gnome.settings-daemon.plugins.power]
          ambient-enabled = false

          [org.gnome.mutter]
          experimental-features = ['scale-monitor-framebuffer', 'variable-refresh-rate']
        '';
        extraGSettingsOverridePackages = with pkgs.gnome; [
          mutter
          gnome-settings-daemon
        ];
      };

      gnome = {
        # Disable all gnome apps (they can be installed with home manager)
        core-utilities.enable = false;
      };
    };

    # Secret manager
    programs.seahorse.enable = true;
  };
}
