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

    # version control for nix-darwin
    system.stateVersion = 4;
}
