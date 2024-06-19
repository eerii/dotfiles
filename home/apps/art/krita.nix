{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.krita.enable = lib.mkEnableOption "enable krita";

  config = lib.mkIf config.krita.enable {
    home.packages = with pkgs; [ krita ];

    persistence.dirs = [ ".local/share/krita" ];
  };
}
