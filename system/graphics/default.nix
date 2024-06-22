{ extra, lib, ... }:
{
  imports = extra.importFiles ./.;

  # Graphics
  hardware.graphics.enable = lib.mkDefault true;
}
