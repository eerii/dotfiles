{ lib, pkgs, ... }:

let
    sf-mono-nerd = import ./sf-mono.nix { inherit lib pkgs; };
in {
    fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
            sf-mono-nerd
        ];
    };
}
