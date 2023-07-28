{ pkgs, config, ... }:
{
    home.packages = with pkgs; [
        rofi-wayland
    ];

    home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink ../rofi;

    xdg.desktopEntries = {
        rofi = {
            name = "Rofi";
            noDisplay = true;
        };
        rofi-theme-selector = {
            name = "Rofi Theme Selector";
            noDisplay = true;
        };
    };
}
