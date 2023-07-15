{ self, ... }:
{
    flake = {
        homeModules = {
            common = { pkgs, ... }: {
                # load modules
                imports = [
                    ./shell/zsh.nix
                    ./shell/clitools.nix
                    ./shell/direnv.nix
                    ./zellij/zellij.nix
                    ./virt/qemu.nix
                    ./media/ffmpeg.nix
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
