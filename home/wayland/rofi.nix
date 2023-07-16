{ pkgs, ... }:
{
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        extraConfig = {
            show-icons = true;
            icon-theme = "Colloid";
            terminal = "kitty";
        };
    };
}
