{ lib, pkgs, ... }:
let
    apple-fonts = import ./apple-fonts.nix { inherit lib pkgs; };
in {
    fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
            # apple-fonts
            (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
        ];
    };
}
