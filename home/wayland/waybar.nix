{
  lib,
  osConfig,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf osConfig.sway.enable {
    programs.waybar = {
      enable = true;
    };
  };
}
