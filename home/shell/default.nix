{ pkgs, ... }:
{
    imports = [
        ./zsh.nix
        ./scripts
        ./zellij
    ];

    home.packages = with pkgs; [
        wget # retrieve files
        aria # improved file downloader
        inetutils # telnet, ping, ifconfig...

        bat # cat
        bottom # top
        du-dust # du
        exa # ls
        fd # find
        procs # ps
        ripgrep # grep
        rm-improved # rm
        zoxide # cd

        tealdeer # man pages

        ffmpeg_6 # multimedia utils
        imagemagick # image utils
    ];

    home.shellAliases = { 
        l = "exa -la --git --group-directories-first";
        ls = "exa";
        cat = "bat";
        du = "dust";
        find = "fd";
        grep = "rg";
        rm = "rip";

        ga = "git add";
        gc = "git commit";
        "gc!" = "git commit --amend";
        gca = "git commit -a -m";
        gp = "git push";
        "gp!" = "git push --force";
        gs = "git status";
        lg = "lazygit";

        a2 = "aria2c";
    };

    programs.direnv = {
        enable = true;
        nix-direnv = {
            enable = true;
        };
    };
}
