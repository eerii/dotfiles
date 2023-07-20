{ self, inputs, ... }:
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
                programs.zsh.enable = true;

                # other packages
                imports = [
                    ./fonts
                ];
            };

            # linux specific modules
            linux = { pkgs, ... }: {
                home-manager.users."eko" = {
                    imports = [
                        self.homeModules.common
                        self.homeModules.linux
                    ];
                };

                imports = [
                    (import ./wayland.nix { inherit pkgs inputs; })
                    ./greetd.nix
                    ./sound.nix
                ];
            };

            # macos specific modules
            darwin = { pkgs, ... }: {
                services.nix-daemon.enable = true; # make sure it always runs

                home-manager.users."eko" = {
                    imports = [
                        self.homeModules.common
                        self.homeModules.darwin
                    ];
                };
            };
        }; 
    };
}
