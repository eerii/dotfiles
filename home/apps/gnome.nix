{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options = {
    gnome-apps.enable = mkEnableOption "enable gnome apps";
  };

  config = mkIf config.gnome-apps.enable {
    home.packages = with pkgs; [
      gnome.nautilus # file explorer
      gnome.sushi # file previewer
      turtle # git integration for nautilus

      gnome.gnome-font-viewer # font viewer
      gnome.dconf-editor # inspect settings
      gnome.gnome-calculator # calculator
      resources # system resources

      loupe # image viewer
      switcheroo # image converter
      papers # pdf viewer
      snapshot # webcam
      apostrophe # simple text editor

      citations # bibliography
      dialect # translation
      gnome-decoder # qr codes
      eyedropper # color picker
    ];

    dconf.settings = {
      "ca/desrt/dconf-editor" = {
        show-warning = false;
      };
    };
  };
}
