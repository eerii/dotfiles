{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.sway = {
    enable = lib.mkEnableOption "enable sway";
    swayfx = lib.mkOption {
      default = true;
      description = "use swayfx over sway";
    };
    resolution = lib.mkOption {
      default = "2560x1600";
      description = "internal display resolution";
    };
    scale = lib.mkOption {
      default = 1.33;
      description = "internal display scale";
    };
  };

  config = lib.mkIf config.sway.enable {
    # We use swayfx over sway to get the display manager configuration
    programs.sway = {
      enable = true;
      package = if config.sway.swayfx then pkgs.swayfx else pkgs.sway;
    };
  };
}
