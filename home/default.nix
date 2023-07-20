{ self, inputs, ... }:
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
                ];

                # home manager can manage itself
                programs.home-manager.enable = true;

                # version control for home manager
                home.stateVersion = "23.05";
            };

            # linux specific home modules
            linux = { pkgs, ... }: {
                imports = [
                    inputs.hyprland.homeManagerModules.default
		            (import ./wayland { inherit pkgs inputs; })
		            ./programs/linux.nix
                ];
            };

            # macos specific home modules
            darwin = {};
        };
    };
}
