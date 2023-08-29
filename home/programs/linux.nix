{ pkgs, ... }:
{
    home.packages = with pkgs; [
        librewolf
        thunderbirdPackages.thunderbird-115
        easyeffects
        mpv
        imv
        zathura
        transmission-gtk
        (callPackage ../../pkgs/beeper.nix {})
    ];

    xdg.desktopEntries = {
        beeper = {
            name = "Beeper";
            exec = "beeper --default-frame --enable-features=UseOzonePlatform --ozone-platform=wayland --no-sandbox %U" ;
        };
    };

    services.easyeffects.enable = true;
}
