{ lib, config, ... }:
with lib;
{
  options = {
    gdm.enable = mkEnableOption "enable gdm";
  };

  # Enable gdm as the login manager
  config = mkIf config.gdm.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # We already install foot, we don't need xterm
      desktopManager.xterm.enable = false;
    };
  };

  # TODO: Gdm window scaling
}
