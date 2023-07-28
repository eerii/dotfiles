{ pkgs, config, ... }:
{
    home.packages = with pkgs; [
        rofi-wayland
    ];

    home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink ../rofi;
}
