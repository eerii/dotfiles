{ inputs, sys, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.disko.nixosModules.default
    ./disko.nix
  ];

  # Ephemeral root partition
  # This script runs every boot and deletes the root btrfs subvolume
  # A backup is saved in old_roots, that gets cleaned every 2 weeks
  boot.initrd = {
    enable = true;
    supportedFilesystems = [ "btrfs" ];

    systemd = {
      enable = true;
      services.restore-root = {
        description = "Rollback btrfs rootfs";
        wantedBy = [ "initrd.target" ];
        requires = [ "dev-mapper-nixos.device" ];
        after = [ "dev-mapper-nixos.device" "systemd-cryptsetup@${sys.hostname}.service" ];
        before = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          echo "rolling back ephemeral root file system"
          mkdir -p /mnt
          mount -o subvol=/ /dev/mapper/nixos /mnt

          if [[ -e /mnt/root ]]; then
              mkdir -p /mnt/old_roots
              timestamp=$(date --date="@$(stat -c %Y /mnt/root)" "+%Y-%m-%-d_%H:%M:%S")
              echo "backing up root to old_roots/$timestamp"
              mv /mnt/root "/mnt/old_roots/$timestamp"
          fi

          delete_subvolume_recursively() {
              echo "deleting $1 subvolume"
              IFS=$'\n'
              for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                  delete_subvolume_recursively "/mnt/$i"
              done
              btrfs subvolume delete "$1"
          }

          for i in $(find /mnt/old_roots/ -maxdepth 1 -mtime +14); do
              delete_subvolume_recursively "$i"
          done

          echo "creating new clean root"
          btrfs subvolume create /mnt/root

          echo "done!"
          umount /mnt
        '';
      };
    };
  };

  # The persist subvolume is needed for the system to boot as impermanence
  # uses it to save the relevant directories and restore them
  fileSystems."/persist".neededForBoot = true;

  # This is needed for hiding mounts from other users
  programs.fuse.userAllowOther = true;

  # This specifies which directories should be kept between reboots
  # NOTE: Anything that is not here or in the similar home-manager configuration will be wiped!
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [ "/etc/machine-id" ];
  };
  environment.persistence."/persist/home" = {
    hideMounts = true;
    users.${sys.username} = {
      directories = [
        "Documentos"
        # NOTE: Downloads gets deleted
        "Imágenes"
        "Videos"
        "Code"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".local/share/zoxide"
      ];
      files = [ ".local/share/fish/fish_history" ];
    };
  };
}
