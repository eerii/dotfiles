{ flake, ... }:
{
    programs.zsh = {
        enable = true;

        enableAutosuggestions = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autocd = true;

        history = {
            expireDuplicatesFirst = true;
            ignorePatterns = [ "clear" "rm *" ];
            save = 100000;
            size = 100000;
        };
        historySubstringSearch.enable = true;

        initExtra = ''
            source ${../../scripts/transient.zsh}
            eval "$(zoxide init zsh)"
            eval "$(direnv hook zsh)"

            dev() {
                if [ $# -eq 0 ]; then
                    echo "Usage: dev <lang>"
                    return 1
                fi
                nix develop ${../..}\#$1 -c zsh
            }
        '';
        envExtra = "export PATH=/run/current-system/sw/bin:/run/current-system/etc/profiles/per-user/${flake.config.users.me}/bin:$PATH";
    };

    programs.starship = {
        enable = true;
        settings = {
            format="$directory$git_branch$fill$git_status$cmd_duration\n $character";
            add_newline = true;

            character = {
                success_symbol = "[⏺](#a6e3a1)";
                error_symbol = "[⏺](#f38ba8)";
                vicmd_symbol = "[](#f9e2af)";
            };

            fill = {
                symbol = " ";
            };

            directory = {
                format = "[]($style)[ ](bg:#2f3447 fg:#81A1C1)[$path](bg:#2f3447 fg:#BBC3DF bold)[]($style)";
                style = "bg:none fg:#2f3447";
                truncation_length = 3;
                truncate_to_repo = false;
            };

            git_branch = {
                format = "[ ]($style)[[ ](bg:#2f3447 fg:#A2DD9D bold)$branch](bg:#2f3447 fg:#86AAEC)[]($style)";
                style = "bg:none fg:#2f3447";
            };

            git_status = {
                format = "[]($style)[$all_status$ahead_behind](bg:#2f3447 fg:#b4befe)[]($style)";
                style = "bg:none fg:#2f3447";
                conflicted = "~";
                ahead =	"⇡$count";
                behind = "⇣$count";
                diverged = "⇡$ahead_count⇣$behind_count";
                up_to_date = "";
                untracked = "?$count";
                stashed = "";
                modified = "!$count";
                staged = "+$count";
                renamed = "";
                deleted = "";
            };

            cmd_duration = {
                min_time = 100;
                format = "[ ]($style)[[ ](bg:#2f3447 fg:#eba0ac bold)$duration](bg:#2f3447 fg:#BBC3DF)[]($style)";
                disabled = false;
                style = "bg:none fg:#2f3447";
            };
        };
    };

    xdg.configFile.".config/starship-transient.toml".text = ''
        format = " $character"
        [character]
        error_symbol = "[⏺](#f38ba8)"
        success_symbol = "[⏺](#a6e3a1)"
        vicmd_symbol = "[](#f9e2af)"
    '';
}
