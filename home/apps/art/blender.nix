{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  options.blender.enable = mkEnableOption "enable blender";

  config = mkIf config.blender.enable {
    home.packages = with pkgs; [ blender-hip ];

    persistence.dirs = [ ".config/blender" ];
  };
}
