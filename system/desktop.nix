{ lib, config, pkgs, ... }:
with lib;
let
  # writeSession = name:
  #   pkgs.writeTextFile {
  #     name = "${name}.desktop";
  #     destination = "/share/wayland-sessions/${name}.desktop";
  #     text = ''
  #       [Desktop Entry]
  #       Name=${name}
  #       Exec=${name}
  #       TryExec=${name}
  #       Type=Application
  #     '';
  #   } // {
  #     providedSessions = [ name ];
  #   };
in {
  options = {
    gnome.enable = mkEnableOption "enable gnome";
    sway = {
      enable = mkEnableOption "enable sway";
      resolution = mkOption {
        default = "1920x1200";
        description = "internal display resolution";
      };

      scale = mkOption {
        default = 2.0;
        description = "internal display scale";
      };
    };
  };

  config = {
    services = mkMerge [
      (mkIf config.gnome.enable {
        # Gnome is used as a fallback window manager. It's not required, but it's useful to have
        # It has to be enabled with nix itself, but the gtk and dconf settings are handled by home-manager
        xserver.desktopManager.gnome.enable = true;
        # Disable all gnome apps (they can be installed with home manager)
        gnome.core-utilities.enable = false;
      })
      (mkIf config.sway.enable {
        displayManager.sessionPackages = [ pkgs.sway ];
      })
    ];
  };
}
