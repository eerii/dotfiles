{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
with lib;
with lib.hm.gvariant;
{
  config = mkIf osConfig.gnome.enable {
    # Gnome extensions
    home.packages = with pkgs.gnomeExtensions; [
      paperwm
      gsconnect
      blur-my-shell
    ];

    dconf.settings = {
      "org/gnome/desktop/input-sources" = {
        sources = [
          (mkTuple [
            "xkb"
            "us+altgr-intl"
          ])
          (mkTuple [
            "xkb"
            "es"
          ])
        ];
        xkb-options = [ "ctrl:nocaps" ];
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/eri/Imagenes/Fondos de pantalla/Scavengers Reign/plants.jpg";
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        home = [ "<Super>a" ];
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/foot/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/firefox/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/foot" = {
        binding = "<Super>s";
        command = "foot";
        name = "Foot";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/firefox" = {
        binding = "<Super>w";
        command = "firefox";
        name = "Firefox";
      };

      "org/gnome/desktop/wm/preferences" = {
        # focus-mode = "sloppy";
        resize-with-right-button = true;
      };

      "org/gnome/desktop/peripherals/keyboard" = {
        delay = mkUint32 180;
        repeat-interval = mkUint32 15;
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "paperwm@paperwm.github.com"
          "gsconnect@andyholmes.github.io"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
          "blur-my-shell@aunetx"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
        ];
        last-selected-power-profile = "power-saver";
        welcome-dialog-last-shown-version = "9999999999";
      };

      "org/gnome/shell/extensions/paperwm" = {
        show-window-position-bar = false;
        show-workspace-indicator = false;
        vertical-margin = 0;
        vertical-margin-bottom = 10;
        window-gap = 10;
        horizontal-margin = 10;
        cycle-width-steps = [
          0.35
          0.5
          0.75
        ];
        winprops = ''['{"wm_class":"foot","preferredWidth":"50%"}']'';
      };

      "org/gnome/shell/extensions/paperwm/keybindings" = {
        new-window = [ "" ];
      };

      "org/gnome/settings-daemon/plugins/power" = {
        ambient-enabled = false;
      };

      "org/gnome/mutter" = {
        experimental-features = [
          "scale-monitor-framebuffer"
          "variable-refresh-rate"
        ];
      };
    };

    persistence.files = [ ".config/monitors.xml" ];
  };
}
