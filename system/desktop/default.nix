{ extra, ... }:
{
  imports = extra.importFiles ./.;

  # Enable wayland in electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
