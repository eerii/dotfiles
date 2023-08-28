{ pkgs, ... }:
{
    home.packages = with pkgs; [
        librewolf
        thunderbirdPackages.thunderbird-115
        easyeffects
        vlc
        imv
        zathura
        (callPackage ../../pkgs/beeper.nix {})
    ];

    services.easyeffects.enable = true;
}
