{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  # This is the computer specific hardware configuration
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    inputs.disko.nixosModules.default
  ];

  # Enable modules
  nextcloud.enable = true;

  boot = {
    # Override kernel
    kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_rpi4;

    # Disable bootloader (it already has one)
    loader.systemd-boot.enable = false;
  };

  # SSH
  services.openssh.enable = true;

  # Extra packages
  environment.systemPackages = with pkgs; [ raspberrypi-eeprom ];

  hardware = {
    graphics.enable = false;

    # GPU support (not really needed since this is a server)
    #hardware.raspberry-pi."4".fkms-3d.enable = true;

    # Audio
    # hardware.raspberry-pi."4".audio.enable = true;
  };

  # Some checks are broken
  nixpkgs.config.allowBroken = true;
}
