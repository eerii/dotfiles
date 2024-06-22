{
  lib,
  config,
  pkgs,
  extra,
  ...
}:
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
      home.packages = with extra.unpkgs; [
        # Microsoft fonts
        corefonts
        vistafonts
      ];
    })
  ];
}
