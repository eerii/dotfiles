{ self, config, ... }:
{
    flake = {
        modules = {
            common = { pkgs, ... }: {
                # nix
                services.nix-daemon.enable = true; # make sure it always runs
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

                # extra modules
                imports = [
                    
                ];
            };

            # linux specific modules
            linux = { pkgs, ... }: {
                home-manager.users.${config.users.me} = {
                    imports = [
                        self.homeModules.common
                        self.homeModules.linux
                    ];
                };
            };

            # macos specific modules
            darwin = { pkgs, ... }: {
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
