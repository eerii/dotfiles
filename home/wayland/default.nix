{ pkgs, ... }:
{
    imports = [
        ./hyprland.nix
    ];

    home.packages = with pkgs; [
    
    ];

    home.sessionVariables = {
        #QT_QPA_PLATFORM = "wayland";
        #SDL_VIDEODRIVER = "wayland";
        #XDG_SESSION_TYPE = "wayland";
    };
}
