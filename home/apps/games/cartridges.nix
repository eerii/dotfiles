{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options = {
    cartridges.enable = mkEnableOption "enable cartridges";
  };

  config = mkIf config.cartridges.enable {
    home.packages = with pkgs; [ cartridges ];

    # Impermanence
    persistence.dirs = [ ".local/share/cartridges" ];
  };
}
