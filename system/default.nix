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
                        "firefox"
                        "git-credential-manager-core"
                        "iterm2"
                        "keka"
                        "maccy"
                        "macfuse"
                        "monitorcontrol"
                        "opencore-patcher"
                        "quarto"
                        "raycast"
                        "spotify"
                        "stremio"
                        "telegram"
                        "visual-studio-code-insiders"
                    ];
                };
            };
        }; 
    };
}
