{ pkgs, ... }:
{
    home.packages = with pkgs; [
        dunst
        libnotify
    ];

    home.file.".config/dunst/dunstrc".text = ''
        [global]
        format = "<b>%s</b>\n%b"

        icon_theme = Colloid
        max_icon_size = 48
        enable_recursive_icon_lookup = true

        origin = top-right
        offset = 22x22
        frame_width = 2
        frame_color = "#11111b"
        separator_color = frame
        font = "SF Mono 10"
        corner_radius = 7
        background = "#11111b"
        foreground = "#cdd6f4" 
    '';
}
