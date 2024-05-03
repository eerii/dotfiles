{ pkgs, config, ... }:
{
  # This is the computer specific hardware configuration
  imports = [ ./hardware-configuration.nix ];

  # Enable modules
  gdm.enable = true;
  gnome.enable = true;
  # TODO: sway.enable = true;
  steam.enable = true;

  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}
