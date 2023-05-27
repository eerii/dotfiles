{ flake, ... }:
{
    programs.zsh = {
        enable = true;

        enableAutosuggestions = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        autocd = true;

        history = {
            expireDuplicatesFirst = true;
            ignorePatterns = [ "clear" "rm *" ];
            save = 100000;
            size = 100000;
        };
        historySubstringSearch.enable = true;

        # TODO: Remove the absolute reference to the system path
        initExtra = ''
            source ~/Programacion/dotfiles/zsh/transient.zsh
            eval "$(zoxide init zsh)"
            eval "$(direnv hook zsh)"

            dev() {
                if [ $# -eq 0 ]; then
                    echo "Usage: dev <lang>"
                    return 1
                fi
                nix develop ~/Programacion/dotfiles/nix\#$1 -c zsh
            }
        '';
        envExtra = "export PATH=/run/current-system/sw/bin:/run/current-system/etc/profiles/per-user/${flake.config.users.me}/bin:$PATH";
    };

    # TODO: move starship configuration here
    programs.starship = {
        enable = true;
    };
}
