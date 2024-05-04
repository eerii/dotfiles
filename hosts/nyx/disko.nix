{ inputs, sys, ... }:
let
  device = sys.device;
  options = [
    "compress=zstd"
    "noatime"
  ];
in
{
  imports = [ inputs.disko.nixosModules.default ];

  # Disko can partition the drive for us automatically
  # Run the following command to format the disk:
  # nix run github:nix-community/disko -- --mode disko PATH_TO_THIS_FILE --arg device '"/dev/DEVICE_NAME"'
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # BIOS boot partition
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
          # Main btrfs partition (encrypted with LUKS)
          # This contains the nix store and two subvolumes for an impermanence setup
          # Root (/) will get deleted every boot, except for the folders saved by impermanence
          # Any content saved on persist will also be fine
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "nixos";
              settings.allowDiscards = true;
              askPassword = true;
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "-L root"
                ];
                # This hook creates a blank snapshot of the root volume that we can restore on each boot
                postCreateHook = ''
                  mnt=$(mktemp -d)
                  mount "/dev/mapper/nixos" "$mnt" -o subvolid=0
                  btrfs subvolume snapshot -r $mnt/@root $mnt/@blank
                  umount "$mnt"
                '';
                subvolumes = {
                  "@root" = {
                    mountOptions = options;
                    mountpoint = "/";
                  };

                  "@persist" = {
                    mountOptions = options;
                    mountpoint = "/persist";
                  };

                  "@nix" = {
                    mountOptions = options;
                    mountpoint = "/nix";
                  };

                  "@swap" = {
                    mountOptions = [ "noatime" ];
                    swap.swapfile.size = sys.swap or "4G";
                    mountpoint = "/swap";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
