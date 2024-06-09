{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cartridges.enable = lib.mkEnableOption "enable cartridges";
  };

  config = lib.mkIf config.cartridges.enable {
    home.packages = with pkgs; [ cartridges ];

    # Impermanence
    persistence.dirs = [ ".local/share/cartridges" ];
  };
}
