{ pkgs, ... }:
{
    services.xserver = {
        enable = true;
        displayManager.gdm = {
            enable = true;
            wayland = true;
        };
        excludePackages = with pkgs; [ xterm ];
    };

    xdg.portal.enable = true;

    hardware = {
        opengl.enable = true;
    };

    # Hyprland
    programs.hyprland.enable = true;

    # Gnome
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (with pkgs.gnome; [
        baobab cheese eog epiphany evince gedit simple-scan totem yelp file-roller geary seahorse
        gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
        gnome-logs gnome-maps gnome-music gnome-screenshot gnome-system-monitor
        gnome-disk-utility gnome-terminal gnome-font-viewer gnome-weather
    ]) ++ (with pkgs; [
        gnome-connections gnome-photos gnome-tour gnome-text-editor xterm
    ]);
}
