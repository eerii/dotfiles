{
  extra,
  inputs,
  sys,
  ...
}:
{
  # Submodules
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ] ++ extra.importFiles ./.;

  # Home manager configuration
  home.stateVersion = "24.05";
}
