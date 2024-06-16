{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.ardour.enable = lib.mkEnableOption "enable ardour";

  config = lib.mkIf config.ardour.enable {
    home.packages = with pkgs; [ ardour ];

    persistence.dirs = [ ".config/ardour8" ];
  };
}
