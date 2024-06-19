{ lib, config, ... }:
{
  options.gdm.enable = lib.mkEnableOption "enable gdm";

  # Enable gdm as the login manager
  config = lib.mkIf config.gdm.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # We already install foot, we don't need xterm
      desktopManager.xterm.enable = false;
    };

    services.displayManager.defaultSession = lib.mkIf config.sway.enable "sway";

    # Unlock keyring with gdm
    security.pam.services.gdm.enableGnomeKeyring = true;
  };
}
