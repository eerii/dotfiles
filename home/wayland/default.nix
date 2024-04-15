{ lib, extra, config, pkgs, ... }:
with lib; {
  imports = extra.importFiles ./.;

  options = { wayland.enable = mkEnableOption "enable wayland"; };

  config = mkIf config.wayland.enable {
    home.packages = with pkgs; [
      # Clipboard
      wl-clipboard

      # Screenshots
      grim
      slurp
      satty
    ];
  };
}
