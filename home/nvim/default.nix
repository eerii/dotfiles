{ config, pkgs, ... }:
{
    programs.neovim = {
        enable = true;
    };

    home.file = {
        ".config/nvim" = {
            source = config.lib.file.mkOutOfStoreSymlink ../nvim;
        };
    };

    home.packages = with pkgs; [
        fzf
        tree-sitter
    ];
}
