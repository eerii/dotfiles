{ pkgs, ... }:
{
    devenv.shells.node = {
        packages = with pkgs; [ nodejs_20 yarn ];
        enterShell = "";
    };

}
