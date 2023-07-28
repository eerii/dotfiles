{ pkgs, ... }:
{
    home.packages = with pkgs; [
        librewolf
        element
        easyeffects
    ];

    services.easyeffects.enable = true;
}
