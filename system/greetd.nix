{ pkgs, ... }:
{
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
                user = "greeter";
            };
        };
    };

    environment.systemPackages = with pkgs; [
        greetd.tuigreet
    ];

    environment.etc = {
        "greetd/environments".text = "zsh";
    };
}
