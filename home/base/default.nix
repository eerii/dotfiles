{ extra, ... }: {
  # Submodules
  imports = extra.importFiles ./.;

  # Home manager configuration
  home.stateVersion = "24.05";
}
