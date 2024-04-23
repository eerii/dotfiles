{ lib, config, pkgs, ... }:
with lib; {
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
        # It has to be enabled with nix itself, but the gtk and dconf settings are handled by home-manager
        xserver.desktopManager.gnome.enable = true;
        # Disable all gnome apps (they can be installed with home manager)
        gnome.core-utilities.enable = false;
      };
    })
    (mkIf config.sway.enable {
      # We use swayfx over sway to get the display manager configuration
      programs.sway = {
        enable = true;
        # package = pkgs.swayfx;
      };
    })
  ];
}
