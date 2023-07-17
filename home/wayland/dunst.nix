{ pkgs, ... }:
{
    services.dunst = {
        enable = true;
        iconTheme = {
            package = pkgs.colloid-icon-theme;
            name = "Colloid";
        };
        settings = {
            global = {
# TODO: Configure dunst (notification daemon)
            };
        };
    };
}
