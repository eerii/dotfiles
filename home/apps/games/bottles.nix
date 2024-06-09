{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    bottles.enable = lib.mkEnableOption "enable bottles";
  };

  config = lib.mkIf config.bottles.enable {
    home.packages = with pkgs; [ bottles ];

    # Impermanence
    persistence.dirs = [ ".local/share/bottles" ];
  };
}
