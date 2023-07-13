{ pkgs, flake, ... }:
{
    # my user
    users.users.${flake.config.users.me} = {
        name = flake.config.users.me;
        home = "/home/${flake.config.users.me}";
    };

    # custom home manager
    home-manager.users.${flake.config.users.me} = { pkgs, ... }: {
        home.sessionVariables = {
           EDITOR = "nvim";
           VISUAL = "nvim";
        };
    };
}
