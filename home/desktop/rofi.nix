{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.wayland.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland-unwrapped;
    };
  };
}
