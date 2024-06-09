{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    matrix.enable = lib.mkEnableOption "enable matrix";
  };

  config = lib.mkIf config.matrix.enable {
    home.packages = with pkgs; [ fractal ];

    # Impermanence
    persistence.dirs = [ ".local/share/fractal" ];
  };
}
