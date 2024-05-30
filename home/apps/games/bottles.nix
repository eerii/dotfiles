{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options = {
    bottles.enable = mkEnableOption "enable bottles";
  };

  config = mkIf config.bottles.enable {
    home.packages = with pkgs; [ bottles ];

    # Impermanence
    persistence.dirs = [ ".local/share/bottles" ];
  };
}
