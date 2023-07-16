{ self, inputs, ... }:
{
    flake = {
        homeModules = {
            common = { pkgs, ... }: {
                # load modules
                imports = [
                    ./shell/zsh.nix
                    ./shell/clitools.nix
                    ./shell/direnv.nix
                    ./terminal/kitty.nix
                    ./zellij
                    ./nvim
                    ./virt/qemu.nix
                    ./misc/ffmpeg.nix
		    ./programs/firefox.nix
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
                ];
            };

            # macos specific home modules
            darwin = {};
        };
    };
}
