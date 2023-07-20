{ pkgs, inputs, ... }:
{
    imports = [
        ./hyprland.nix
        ./rofi
        (import ./waybar { inherit pkgs inputs; })
    ];

    home.packages = with pkgs; [
        dunst
        libnotify
        hyprpicker
        swww
        colloid-icon-theme
    ];

    # TODO: Wayland install:
    #   - pipewire (screen sharing)
    #   - clipboard manager
}
