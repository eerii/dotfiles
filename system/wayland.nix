{ pkgs, inputs, ... }:
{
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            #inputs.xdg-portal-hyprland.packages.${pkgs.system}.default
        ];
    };

    hardware = {
        opengl.enable = true;
    };

    programs.hyprland.enable = true;
}
