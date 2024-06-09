{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  # Allow unfree font packages
  unpkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  options = {
    microsoft-fonts.enable = lib.mkEnableOption "enable microsoft fonts";
  };

  config = lib.mkMerge [
    {
      fonts.fontconfig.enable = true;

      home.packages = with pkgs; [
        # Console fonts
        jetbrains-mono
        (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ];
    }
    (lib.mkIf config.microsoft-fonts.enable {
      home.packages = with unpkgs; [
        # Microsoft fonts
        corefonts
        vistafonts
      ];
    })
  ];
}
