{ extra, lib, ... }:
{
  imports = extra.importFiles ./.;

  # Graphics
  hardware.opengl = {
    enable = lib.mkDefault true;
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };
}
