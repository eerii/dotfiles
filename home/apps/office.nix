{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    office.enable = lib.mkEnableOption "enable office";
  };

  config = lib.mkIf config.office.enable {
    home.packages = with pkgs; [ libreoffice-fresh ];

    # Impermanence
    persistence.dirs = [ ".config/libreoffice" ];
  };
}
