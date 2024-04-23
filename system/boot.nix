{ pkgs, ... }: {
  boot = {
    # Latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Kernel params
    kernelParams = [ "quiet" "splash" ];

    # UEFI bootloader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    plymouth = { enable = true; };

    # TODO: Secure boot
    # TODO: Plymouth
    # TODO: Single password prompt https://discourse.nixos.org/t/encrypted-root-with-single-password-prompt/17054/8
  };
}
