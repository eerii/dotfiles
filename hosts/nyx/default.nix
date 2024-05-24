{ pkgs, config, inputs, ... }:
{
  # This is the computer specific hardware configuration
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    inputs.disko.nixosModules.default
  ];

  # Enable modules
  gdm.enable = true;
  gnome.enable = true;
  impermanence.enable = true;
  sway.enable = true;
  sway.swayfx = false; # TODO: Swayfx
  steam.enable = true;

  # Drivers
  services.xserver.videoDrivers = [ "amdgpu" ];
}
