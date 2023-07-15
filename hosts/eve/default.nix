{ pkgs, flake, ... }:
{
    # my user
    users.users.${flake.config.users.me} = {
        name = flake.config.users.me;
        home = "/Users/${flake.config.users.me}";
    };

    # custom home manager
    home-manager.users.${flake.config.users.me} = { pkgs, ... }: {
        home.sessionVariables = {
           EDITOR = "nvim";
           VISUAL = "nvim";
        };
    };

    # homebrew (used for casks and mas apps)
    homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        casks = [
            "firefox"
            "git-credential-manager-core"
            "iterm2"
            "keka"
            "maccy"
            "macfuse"
            "monitorcontrol"
            "opencore-patcher"
            "quarto"
            "raycast"
            "spotify"
            "stremio"
            "telegram"
            "visual-studio-code-insiders"
        ];
    };

    # version control for nix-darwin
    system.stateVersion = 4;
}
