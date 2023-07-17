{ pkgs, flake, ... }:
{
    services.greetd = {
        enable = true;
        restart = false;

        settings = {
            default_session = {
                command = "${pkgs.greetd.regreet}/bin/regreet --cmd Hyprland";
                user = "greeter";
            };

            initial_session = {
                command = "${pkgs.hyprland}/bin/Hyprland";
                user = flake.config.users.me;
            };
        };
    };
}
