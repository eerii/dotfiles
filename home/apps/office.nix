{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  options = {
    office.enable = mkEnableOption "enable office";
  };

  config = mkIf config.office.enable {
    home.packages = with pkgs; [ libreoffice-fresh ];

    # Impermanence
    persistence.dirs = [ ".config/libreoffice" ];
  };
}
