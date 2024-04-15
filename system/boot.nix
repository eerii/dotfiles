{ pkgs, ... }: {
  boot = {
    # Latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Kernel params
    kernelParams = [ "quiet" "splash" ];

    # UEFI bootloader
    loader = {
      grub.enable = true;
      # TODO: systemd-boot.enable = true;
      timeout = 0;
    };
  };
}
