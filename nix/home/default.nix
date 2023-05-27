{ self, ... }:
{
    flake = {
        homeModules = {
            common = { pkgs, ... }: {
                # load modules
                imports = [
                    ./direnv.nix
                    ./shell/zsh.nix
                    ./shell/zellij.nix
                    ./shell/clitools.nix
                    ./virt/qemu.nix
                ];

                # home manager can manage itself
                programs.home-manager.enable = true;

                # version control for home manager
                home.stateVersion = "22.11";
            };

            # linux specific home modules
            linux = {};

            # macos specific home modules
            darwin = {};
        };
    };
}
