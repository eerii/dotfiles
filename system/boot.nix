{ pkgs, lib, ... }:
{
  boot = {
    # Latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Kernel params
    kernelParams = [
      "quiet"
      "splash"
    ];

    # UEFI bootloader
    loader = {
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
      timeout = 0;
    };

    # Plymouth (graphical boot)
    # TODO: Add a plymouth theme
    plymouth.enable = true;

    # Maybe add secure boot
    # Single password prompt https://discourse.nixos.org/t/encrypted-root-with-single-password-prompt/17054/8
  };
}
