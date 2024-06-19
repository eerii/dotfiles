{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.inkscape.enable = lib.mkEnableOption "enable inkscape";

  config = lib.mkIf config.inkscape.enable {
    home.packages = with pkgs; [ inkscape ];

    persistence.dirs = [ ".config/inkscape" ];
  };
}
