{
  lib,
  extra,
  config,
  pkgs,
  ...
}:
with lib;
{
  imports = extra.importFiles ./.;

  options = {
    wayland.enable = mkEnableOption "enable wayland";
  };
}
