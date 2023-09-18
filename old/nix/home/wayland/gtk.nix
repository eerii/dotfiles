{ pkgs, ... }:
{
    gtk = {
        enable = true;
        cursorTheme = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 24;
        };
        iconTheme = {
            package = pkgs.colloid-icon-theme;
            name = "Colloid";
        };
    };
}
