{ config, pkgs, ... }:
{
    programs.neovim = {
        enable = true;
    };

    xdg.configFile.".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink ../nvim;
    };

    home.packages = with pkgs; [
        fzf
        tree-sitter
    ];
}
