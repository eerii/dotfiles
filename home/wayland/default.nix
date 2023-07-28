{ pkgs, inputs, ... }:
{
    imports = [
        ./hyprland.nix
        ./gnome.nix
        ./gtk.nix
        ./dunst.nix
        ./rofi
        ./waybar
    ];

    home.packages = with pkgs; [
        hyprpicker
        swww
        wl-clipboard
        wtype
        colloid-icon-theme
        inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ]; 
}
