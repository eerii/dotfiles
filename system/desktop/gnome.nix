{ lib, config, ... }:
with lib;
{
  options.gnome.enable = mkEnableOption "enable gnome";

  config = mkIf config.gnome.enable {
    services = {
      xserver.desktopManager.gnome.enable = true;
      gnome = {
        # Disable all gnome apps (they can be installed with home manager)
        core-utilities.enable = false;
      };
    };

    # Secret manager
    programs.seahorse.enable = true;
  };
}
