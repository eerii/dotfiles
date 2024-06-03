{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  options.sway = {
    enable = mkEnableOption "enable sway";
    swayfx = mkOption {
      default = true;
      description = "use swayfx over sway";
    };
    resolution = mkOption {
      default = "2560x1600";
      description = "internal display resolution";
    };
    scale = mkOption {
      default = 1.33;
      description = "internal display scale";
    };
  };

  config = mkIf config.sway.enable {
    # We use swayfx over sway to get the display manager configuration
    programs.sway = {
      enable = true;
      package = if config.sway.swayfx then pkgs.swayfx else pkgs.sway;
    };
  };
}
