{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.gimp.enable = lib.mkEnableOption "enable gimp";

  config = lib.mkIf config.gimp.enable {
    home.packages = with pkgs; [ gimp-devel ];

    persistence.dirs = [ ".config/GIMP" ];
  };
}
