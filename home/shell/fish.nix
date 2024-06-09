{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    fish.enable = lib.mkEnableOption "enable fish";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      plugins = [
        # Clean failed and duplicated commands from history
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge.src;
        }
        # Receive notifications after a command is done
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        # Faster prompt loading (useful for slow git directories)
        {
          name = "async-prompt";
          src = pkgs.fishPlugins.async-prompt.src;
        }
        # Use bash syntax
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
      ];
      interactiveShellInit = ''
        # Use nix shell with fish by default
        nix-your-shell fish | source

        # Disable greeting
        set fish_greeting

        # Only clean failed commands on exit
        set sponge_purge_only_on_exit true

        # Load passwords
        set -x (gnome-keyring-daemon --start 2> /dev/null | string split "=")
      '';
      shellAbbrs = {
        # Git
        gs = "git status";
        ga = "git add";
        gc = {
          expansion = ''git commit -m "%"'';
          setCursor = true;
        };
        "gc!" = "git commit --amend";
        gp = "git push";
        "gp!" = "git push --force";
        gd = "git diff";
        gr = "git rebase";
        gfr = "git fetch upstream main && git rebase upstream/main --autostash";
        gss = "git stash";
        gsp = "git stash pop";

        # Cli utils
        rm = "rip";
        "rm!" = "command rm -rf";
        ls = "eza";
        grep = "rg";
        cat = "bat";
        tree = "eza -T";
        find = "fd";
        n = "nvim";

        # Nix
        ns = "nix shell nixpkgs#";

        # Other
        todo = ''rg TODO -NI --trim | sed "s/.*TODO:/- [ ]/"'';
        sys = "systemctl --user";
        ssys = "sudo systemctl";
        jr = "sudo journalctl --boot";
      };
      functions = {
        # Prompt
        fish_prompt = ''
          if test -n "$SSH_TTY"
              echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
          end

          if test -n "$IN_NIX_SHELL"
              echo -n (set_color blue)" "
          else if echo "$PATH" | grep -qc '/nix/store'
              echo -n (set_color blue)" "
          end

          echo -n (set_color brmagenta)(path basename -- $PWD)

          if fish_is_root_user
              echo -n (set_color red)'# '
          end
          echo -n (set_color 444 brblack)': '
          set_color normal
        '';
        fish_right_prompt_loading_indicator = {
          argumentNames = [ "last_prompt" ];
          body = ''
            echo -n "$last_prompt" | sed -r 's/\x1B\[[0-9;]*[JKmsu]//g' | read -zl uncolored_last_prompt
            echo -n (set_color brblack)"$uncolored_last_prompt"(set_color normal)
          '';
        };
      };
    };

    # Impermanence
    persistence.dirs = [ ".local/share/fish" ];

    # Use in nix shell
    home.packages = with pkgs; [ nix-your-shell ];
  };
}
