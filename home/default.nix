{ self, config, inputs, ... }:
{
    flake = {
        homeModules = {
            common = { pkgs, ... }: {
                # load modules
                imports = [
                    ./shell
                    ./terminal
                    ./nvim
                    ./programs
                    ./pass
                ];

                # home manager can manage itself
                programs.home-manager.enable = true;

                # version control for home manager
                home.stateVersion = "23.05";
            };

            # linux specific home modules
            linux = { pkgs, config, ... }: {
                imports = [
                    inputs.hyprland.homeManagerModules.default
		            (import ./wayland { inherit pkgs inputs; })
		            ./programs/linux.nix
                ];

                xdg.userDirs = {
                    enable = true;
                    createDirectories = true;

                    desktop = "Desktop";
                    documents = "Documents";
                    download = "Downloads";
                    music = null;
                    pictures = "Pictures";
                    publicShare = null;
                    templates = null;
                    videos = null;
                    extraConfig = {
                        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
                    };
                };

                xdg.desktopEntries.nixos-manual = {
                    name = "NixOS Manual";
                    noDisplay = true;
                };
            };

            # macos specific home modules
            darwin = {};
        };
    };
}
