{ sys, ... }:
let device = sys.device;
in {
  # Disko can partition the drive for us automatically
  # Run the following command to format the disk:
  # nix run github:nix-community/disko --mode disko PATH_TO_THIS_FILE --arg device '"/dev/DEVICE_NAME"'
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # BIOS boot partition
          # TODO: Is this necessary?
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          # EFI boot partition (/boot)
          esp = {
            name = "EFI";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          # Main btrfs partition
          # This contains the nix store and two subvolumes for an impermanence setup
          # Root (/) will get deleted every boot, except for the folders saved by impermanence
          # Any content saved on persist will also be fine
          root = {
            name = "root";
            label = "rootfs";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];

              subvolumes = {
                "/root" = { mountpoint = "/"; };

                "/persist" = {
                  mountOptions = [ "subvol=persist" "noatime" ];
                  mountpoint = "/persist";
                };

                "/nix" = {
                  mountOptions = [ "subvol=nix" "noatime" ];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };
}