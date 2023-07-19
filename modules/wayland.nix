{ pkgs, ... }:
{
    xdg.portal = {
        enable = true;
        wlr.enable = false;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            #inputs.xdg-portal-hyprland.packages.${system}.default
        ];
    };

    hardware = {
        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
            extraPackages = with pkgs; [];
        };
        pulseaudio.support32Bit = true;
    };

    sound = {
        enable = true;
        mediaKeys.enable = true;
    };
}
