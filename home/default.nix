{ lib, extra, ... }:
with lib; {
  # Submodules
  imports = extra.importFiles ./.;

  # Modules enabled by default
  neovim.enable = mkDefault true;

  # Home manager configuration
  home.stateVersion = "24.05";
}
