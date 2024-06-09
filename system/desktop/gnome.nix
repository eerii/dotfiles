{ lib, config, ... }:
{
  options.gnome.enable = lib.mkEnableOption "enable gnome";

  config = lib.mkIf config.gnome.enable {
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
