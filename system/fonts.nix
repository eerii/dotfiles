{ pkgs, inputs, ... }:
let 
    apple = inputs.apple-fonts.packages.${pkgs.system};
in
{
    fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
            (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
            apple.sf-pro
            apple.sf-compact
            apple.sf-mono
            apple.sf-mono-nerd
            apple.ny
        ];
    };
}
