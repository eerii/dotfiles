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

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "paperwm@paperwm.github.com"
          "gsconnect@andyholmes.github.io"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
        ];
        last-selected-power-profile = "power-saver";
        welcome-dialog-last-shown-version = "9999999999";
      };

      "org/gnome/shell/extensions/paperwm" = {
        "show-window-position-bar" = false;
        "show-workspace-indicator" = false;
        "vertical-margin" = 0;
        "vertical-margin-bottom" = 10;
        "window-gap" = 10;
        "horizontal-margin" = 10;
        "winprops" = [ ''{"wm_class":"foot","preferredWidth":"50%"}'' ];
      };
    };

    persistence.files = [ ".config/monitors.xml" ];
  };
}
