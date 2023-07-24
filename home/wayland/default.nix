{ pkgs, inputs, ... }:
{
    imports = [
        ./hyprland.nix
        ./rofi
    ];

    home.packages = with pkgs; [
        dunst
        libnotify
        hyprpicker
        swww
        colloid-icon-theme
    ];

    # TODO: Wayland install:
    #   - eww bar + widgets
    #   - pipewire (screen sharing)
    #   - clipboard manager
}
