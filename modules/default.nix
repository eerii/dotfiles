{ self, config, ... }:
{
    flake = {
        modules = {
            common = { pkgs, ... }: {
                # nix
                nix = {
                    package = pkgs.nixVersions.unstable;
                    settings.experimental-features = [ "nix-command" "flakes" ];
                };
                nixpkgs.config.allowUnfree = true;

                # system packages
                environment.systemPackages = with pkgs; [
                    git
                    vim
                ];

                imports = [
                    ./fonts
                ];
            };

            # linux specific modules
            linux = { pkgs, ... }: {
                home-manager.users.${config.users.me} = {
                    imports = [
                        self.homeModules.common
                        self.homeModules.linux
                        ./wayland.nix
                        ./greetd.nix
                    ];
                };
            };

            # macos specific modules
            darwin = { pkgs, ... }: {
                services.nix-daemon.enable = true; # make sure it always runs

                home-manager.users.${config.users.me} = {
                    imports = [
                        self.homeModules.common
                        self.homeModules.darwin
                    ];
                };
            };
        }; 
    };
}
