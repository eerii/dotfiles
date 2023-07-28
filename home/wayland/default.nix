{ pkgs, inputs, ... }:
{
    imports = [
        ./hyprland.nix
        ./gtk.nix
        ./rofi
        (import ./waybar { inherit pkgs inputs; })
    ];

    home.packages = with pkgs; [
        dunst
        libnotify
        hyprpicker
        swww
        wl-clipboard
        colloid-icon-theme
        inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ]; 
}
