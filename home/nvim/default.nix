{ config, pkgs, ... }:
{
    home.file.".config/nvim" = {
        source = ../nvim;
        recursive = true;
    };

    home.packages = with pkgs; [
        neovim
        fzf
        tree-sitter
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };
}
