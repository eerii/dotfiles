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
      default = 1.3333;
      description = "internal display scale";
    };
  };

  config = lib.mkIf config.sway.enable {
    # We use swayfx over sway to get the display manager configuration
    programs.sway = {
      enable = true;
      package = if config.sway.swayfx then pkgs.swayfx else pkgs.sway;
    };

    # Environment
    environment.sessionVariables = {
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "gtk2";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      _JAVA_AWT_WM_NONREPARENTING = 1;
      NIXOS_OZONE_WL = 1;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
      config.common.default = [ "wlr" ];
    };
  };
}
