{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf config.wayland.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland-unwrapped;
    };
  };
}
