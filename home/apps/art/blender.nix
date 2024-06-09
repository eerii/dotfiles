{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.blender.enable = lib.mkEnableOption "enable blender";

  config = lib.mkIf config.blender.enable {
    home.packages = with pkgs; [ blender-hip ];

    persistence.dirs = [ ".config/blender" ];
  };
}
