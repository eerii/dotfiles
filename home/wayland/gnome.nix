{ pkgs, ... }:
{
    home.packages = (with pkgs.gnome; [
        gnome-tweaks
    ]) ++ (with pkgs.gnomeExtensions; [
        
    ]);
}
