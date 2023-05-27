{ self, config, ... }:
{
    flake = {
        nixosModules = {
            common = { pkgs, ... }: {
                # nix
                services.nix-daemon.enable = true; # make sure it always runs
                nix = {
                    package = pkgs.nixVersions.unstable;
                    extraOptions = "experimental-features = nix-command flakes";
                };

                # system packages
                environment.systemPackages = with pkgs; [
                    git
                ];

                # extra modules
                imports = [
                    
                ];
            };

            # linux specific modules
            linux = { pkgs, ... }: {

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
