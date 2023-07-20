{ pkgs, config, ... }:
{
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
    };

    # Taken from https://github.com/m4xshen/dotfiles
    home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink ../rofi;
}
