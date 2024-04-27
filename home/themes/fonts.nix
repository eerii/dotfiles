{
  inputs,
  lib,
  config,
  ...
}:
with lib;
let
  # Allow unfree font packages
  unpkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  options = {
    microsoft-fonts.enable = mkEnableOption "enable microsoft fonts";
  };

  config = {
    fonts.fontconfig.enable = true;

    home.packages =
      with unpkgs;
      [
        # Console fonts
        jetbrains-mono
        (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ]
      ++ (optionals config.microsoft-fonts.enable [
        # Microsoft fonts
        corefonts
        vistafonts
      ]);
  };
}
