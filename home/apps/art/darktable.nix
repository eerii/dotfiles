{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.darktable.enable = lib.mkEnableOption "enable darktable";

  config = lib.mkIf config.darktable.enable {
    home.packages = with pkgs; [ darktable ];

    persistence.dirs = [ ".config/darktable" ];
  };
}
