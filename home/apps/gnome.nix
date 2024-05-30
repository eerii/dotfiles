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
      gnome.gnome-font-viewer # font viewer
      gnome.dconf-editor # inspect settings

      loupe # image viewer
      switcheroo # image converter
      snapshot # webcam
      citations # bibliography
      gnome-decoder # qr codes
      dialect # translation
      eyedropper # color picker
      fragments # torrent
      resources # system resources
    ];
  };
}
