{ pkgs, inputs, ... }:
{
    imports = [
        ./hyprland.nix
        ./gtk.nix
        ./dunst.nix
        ./rofi
        (import ./waybar { inherit pkgs inputs; })
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
