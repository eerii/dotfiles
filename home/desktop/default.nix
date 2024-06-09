{
  lib,
  extra,
  ...
}:
{
  imports = extra.importFiles ./.;

  options = {
    wayland.enable = lib.mkEnableOption "enable wayland";
  };
}
