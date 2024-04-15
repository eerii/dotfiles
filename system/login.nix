{ lib, config, ... }:
with lib; {
  options = { gdm.enable = mkEnableOption "enable gdm"; };

  config = mkIf config.gdm.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
