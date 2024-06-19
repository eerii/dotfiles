{
  lib,
  config,
  pkgs,
  ...
}:
let
  lowBattery = pkgs.writeShellScriptBin "lowBattery" ''
    BAT_PCT=`${pkgs.acpi}/bin/acpi -b | grep -Po '[0-9]+(?=%)'`
    BAT_STA=`${pkgs.acpi}/bin/acpi -b | grep -Po '\w+(?=,)'`
    test $BAT_PCT -le 15 && test $BAT_PCT -gt 5 && test $BAT_STA = "Discharging" && dunstify -u normal "Low Battery" "Please get the charger 🥺"
    test $BAT_PCT -le 5 && test $BAT_STA = "Discharging" && dunstify -u critical "Critical Battery" "I'm dying 💀"
  '';
in
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
      config.sway.default = [ "wlr" ];
    };

    # Low battery
    services.cron.systemCronJobs = [ "*/3 * * * * ${lowBattery}/bin/lowBattery 2>&1" ];
  };
}
