{ extra, lib, ... }:
with lib;
{
  imports = extra.importFiles ./.;

  # Graphics
  hardware.opengl = {
    enable = mkDefault true;
    driSupport = mkDefault true;
    driSupport32Bit = mkDefault true;
  };
}
