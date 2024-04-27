{
  lib,
  config,
  pkgs,
  sys,
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
    home.persistence."/persist/home/${sys.username}".directories = [ ".local/share/fractal" ];
  };
}
