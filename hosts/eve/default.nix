{ pkgs, flake, ... }:
{
    # my user
    users.users."eko" = {
        name = "eko";
        home = "/Users/eko";
    };

    # custom home manager
    home-manager.users."eko" = { pkgs, ... }: { 
	    programs.zsh.envExtra = "export PATH=/run/current-system/sw/bin:/run/current-system/etc/profiles/per-user/eko/bin:$PATH";
    };

    # homebrew (used for casks and mas apps)
    homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        brews = [
            "gnupg"
            "pinentry-mac"
        ];
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
