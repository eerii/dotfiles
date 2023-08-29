{ self, inputs, ... }:
{
    flake = {
        modules = {
            common = { pkgs, ... }: {
                # nix
                nix = {
                    package = pkgs.nixVersions.unstable;
                    settings = {
                        experimental-features = [ "nix-command" "flakes" ];
                        warn-dirty = false;
                    };
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
                    (import ./fonts.nix { inherit pkgs inputs; })
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
                    ./desktop.nix
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

                # homebrew (used for casks and mas apps)
                homebrew = {
                    enable = true;
                    onActivation.autoUpdate = true;
                    onActivation.upgrade = true;
                    brews = [
                        "gnupg"
                        "pinentry-mac"
                    ];
                    casks = [
                        "beeper"
                        "git-credential-manager-core"
                        "keka"
                        "librewolf"
                        "maccy"
                        "macfuse"
                        "monitorcontrol"
                        "opencore-patcher"
                        "quarto"
                        "spotify"
                        "stremio"
                        "telegram"
                        "visual-studio-code-insiders"
                    ];
                };
            };

            # gaming specific modules
            gaming = { pkgs, ... }: {
                home-manager.users."eko" = {
                    imports = [
                        self.homeModules.gaming
                    ];
                };

                environment.systemPackages = with pkgs; [
                    wineWowPackages.waylandFull
                ];
            };
        }; 
    };
}
