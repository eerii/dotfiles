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
                    ./zellij
                    ./nvim
                    ./virt/qemu.nix
                    ./misc/ffmpeg.nix
                ];

                # home manager can manage itself
                programs.home-manager.enable = true;

                # version control for home manager
                home.stateVersion = "23.05";
            };

            # linux specific home modules
            linux = {
                imports = [
                    inputs.hyprland.homeManagerModules.default
                    ./wayland
                    ./terminal/kitty.nix
                ];
            };

            # macos specific home modules
            darwin = {};
        };
    };
}
