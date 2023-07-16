{ config, ... }:
{
    programs.zellij = {
        enable = true;
    };

    home.file.".config/zellij" = {
        source = config.lib.file.mkOutOfStoreSymlink ../zellij;
    };
}
