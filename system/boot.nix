{ pkgs, lib, ... }:
with lib; {
  boot = {
    # Latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Kernel params
    kernelParams = [ "quiet" "splash" ];

    # UEFI bootloader
    loader = {
      systemd-boot.enable = mkDefault true;
      efi.canTouchEfiVariables = mkDefault true;
      timeout = 0;
    };

    plymouth = { enable = true; };

    # TODO: Secure boot
    # TODO: Single password prompt https://discourse.nixos.org/t/encrypted-root-with-single-password-prompt/17054/8
  };
}
