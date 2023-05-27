{ pkgs, flake, ... }:
{
    # my user
    users.users.${flake.config.users.me} = {
        name = flake.config.users.me;
        home = "/home/${flake.config.users.me}";
        extraGroups = [ "wheel" "networkmanager" ];
    };

    # custom home manager
    home-manager.users.${flake.config.users.me} = { pkgs, ... }: {
        home.sessionVariables = {
           EDITOR = "nvim";
           VISUAL = "nvim";
        };
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
