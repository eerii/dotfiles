{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  options = {
    matrix.enable = mkEnableOption "enable matrix";
  };

  config = mkIf config.matrix.enable {
    home.packages = with pkgs; [ fractal ];

    # Impermanence
    persistence.dirs = [ ".local/share/fractal" ];
  };
}
