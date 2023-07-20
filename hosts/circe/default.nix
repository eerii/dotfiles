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
            systemd-boot.enable = true;
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi";
		    };
        };
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
