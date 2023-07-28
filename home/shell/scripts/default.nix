{ pkgs, ... }:
let
    screenshot = pkgs.writeShellScriptBin "screenshot" ( builtins.readFile ./screenshot );
in
{
    home.packages = [
        screenshot
    ];
}
