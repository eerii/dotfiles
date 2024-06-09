{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.wayland.enable {
    services.dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = "32x32";
      };
      settings = {
        global = {
          origin = "top-right";
          offset = "22x22";
          format = ''
            <b>%s</b>
            %b'';
          frame_width = 2;
          frame_color = "#b4befe";
          separator_color = "frame";
          font = "Inter 10";
          corner_radius = 7;
          background = "#11111b";
          foreground = "#cdd6f4";
        };
      };
    };
  };
}
