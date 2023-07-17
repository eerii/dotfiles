{ config, ... }:
{
    programs.zellij = {
        enable = true;
    };

    xdg.configFile.".config/zellij" = {
        source = config.lib.file.mkOutOfStoreSymlink ../zellij;
    };
}
