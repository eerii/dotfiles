{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.obs.enable = lib.mkEnableOption "enable obs";

  config = lib.mkIf config.obs.enable {
    home.packages = with pkgs; [ obs-studio ];

    persistence.dirs = [ ".config/obs-studio" ];
  };
}
