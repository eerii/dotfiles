{ pkgs, flake, ... }:
{
    imports = [./hardware-configuration.nix];

    # my user
    users.users."eko" = {
        name = "eko";
        home = "/home/eko";
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.zsh;
	    isNormalUser = true;
    };

    # boot
    boot = {
        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 4;
            };
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi";
		    };
        };

        plymouth = {
            enable = true;
            theme = "breeze";
        };
        initrd = {
            systemd.enable = true;
            verbose = false;
        };
        consoleLogLevel = 0;
        kernelParams = [ "quiet" "boot.shell_on_fail" ];

        extraModprobeConfig = ''
            options snd-hda-intel model=mbp11
        '';
    };

    # network
    networking = {
        hostName = "circe";
        networkmanager.enable = true;
    };

    # locale
    time.timeZone = "Europe/Madrid";
    i18n.defaultLocale = "es_ES.UTF-8";

    # version control for nixos
    system.stateVersion = "23.05";
}
