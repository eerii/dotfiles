{ pkgs, ... }:
{
    home.packages = with pkgs; [
        librewolf
        element
        easyeffects
    ];
}
