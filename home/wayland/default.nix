{ pkgs, inputs, ... }:
{
    imports = [
        ./hyprland.nix
        ./hyprpaper.nix
        ./dunst.nix
        ./rofi.nix
        (import ./waybar.nix { inherit pkgs inputs; })
    ];

    home.packages = with pkgs; [
        hyprpicker
        colloid-icon-theme
    ];

    home.sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_DESKTOP = "Hyprland";
    };

    # TODO: Wayland install:
    #   - pipewire (screen sharing)
    #   - swww (animated wallpapers)
    #   - clipboard manager
}
