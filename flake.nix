{
    description = "eko's setup";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        # nix-darwin: nixos-like configuration for macos
        nix-darwin = {
            url = "github:lnl7/nix-darwin/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # home-manager: user environment and dotfile management with nix
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # flake-parts and nixos-flakes: unify home manager, nixos and darwin
        flake-parts.url = "github:hercules-ci/flake-parts";
        nixos-flake.url = "github:srid/nixos-flake";

        # other packages
        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland-contrib = {
            url = "github:hyprwm/contrib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        apple-fonts = {
            url = "github:Lyndeno/apple-fonts.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # dev toolchain
        devenv.url = "github:cachix/devenv";
        rust-overlay = {
            url = "github:oxalica/rust-overlay";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, ... }:
        inputs.flake-parts.lib.mkFlake { inherit inputs; } {
            systems = [ "x86_64-linux" "x86_64-darwin" ];
            imports = [
                inputs.nixos-flake.flakeModule
                inputs.devenv.flakeModule
                ./system
                ./home
            ];

            flake = {
                # linux
                nixosConfigurations = {
                    # my macbook on nixos
                    circe = self.nixos-flake.lib.mkLinuxSystem {
                        imports = [
                            self.modules.common
                            self.modules.linux
                            self.modules.gaming
                            self.nixosModules.home-manager
                            ./hosts/circe/default.nix
                        ];
                    };
                };

                # macos
                darwinConfigurations = {
                    # my macbook on macos
                    eve = self.nixos-flake.lib.mkMacosSystem {
                        nixpkgs.hostPlatform = "x86_64-darwin";
                        imports = [
                            self.modules.common
                            self.modules.darwin
                            self.darwinModules.home-manager
                            ./hosts/eve/default.nix
                        ];
                    };
                };
            };

            perSystem = { self', inputs', system, pkgs, ... }: {
                imports = [
                    # developer environments
                    # only general envs are defined here, for more control use a custom devenv flake for the project
                    (import ./dev/rust.nix { inherit inputs system pkgs; })
                    ./dev/cpp.nix
                    ./dev/node.nix
                ];
            };
        };
}
