{
  inputs,
  sys,
  lib,
  config,
  ...
}:
with lib;
{
  options.impermanence.enable = mkEnableOption "enable impermanence";

  imports = [ inputs.impermanence.nixosModules.impermanence ];

  config = mkMerge [
    (mkIf config.impermanence.enable {
      # This specifies which directories should be kept between reboots
      # NOTE: Anything that is not here will be wiped!
      environment.persistence."/persist" = {
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/lib/bluetooth"
          {
            directory = "/var/lib/colord";
            user = "colord";
            group = "colord";
            mode = "0750";
          }
          "/etc/NetworkManager/system-connections"
        ];
        files = [
          "/etc/machine-id"
          "/var/db/sudo/lectured"
        ];
      };

      # Ephemeral root partition
      # This script runs every boot and deletes the root btrfs subvolume
      # A backup is saved in old_roots, that gets cleaned every 2 weeks
      boot.initrd = {
        enable = true;
        supportedFilesystems = [ "btrfs" ];

        systemd = {
          enable = true;
          services.rollback = {
            description = "Rollback btrfs root";
            wantedBy = [ "initrd.target" ];
            requires = [ "dev-mapper-nixos.device" ];
            after = [
              "dev-mapper-nixos.device"
              "systemd-cryptsetup@${sys.hostname}.service"
            ];
            before = [ "sysroot.mount" ];
            unitConfig.DefaultDependencies = "no";
            serviceConfig.Type = "oneshot";
            script = ''
              # TODO: VERY IMPORTANT, CREATE BACKUPS!!!
              echo "rolling back ephemeral root file system"
              mkdir -p /tmp
              mnt=$(mktemp -d)

              mount -t btrfs -o subvolid=0 /dev/mapper/nixos $mnt

              echo "cleaning the root subvolume"
              btrfs subvolume list -o "$mnt/@root" | cut -f9 -d ' ' |
              while read -r subvolume; do
                echo "deleting $subvolume..."
                btrfs subvolume delete "$mnt/$subvolume"
              done && echo "deleting @root..." && btrfs subvolume delete "$mnt/@root"

              echo "creating new clean @root"
              btrfs subvolume snapshot "$mnt/@blank" "$mnt/@root"

              echo "done!"
              umount $mnt
            '';
          };
        };
      };

      # The persist subvolume is needed for the system to boot as impermanence
      # uses it to save the relevant directories and restore them
      fileSystems."/persist".neededForBoot = true;

      # This is needed for hiding mounts from other users
      programs.fuse.userAllowOther = true;

      # Create the persist home with propper permissions
      system.activationScripts.persistent-dirs.text = ''
        mkdir -p /persist/home/${sys.username}
        chown ${sys.username} /persist/home/${sys.username}
      '';
    })

    (mkIf (!config.impermanence.enable) { environment.persistence = { }; })
  ];
}
