{
    description = "eko's setup";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        # nix-darwin: nixos-like configuration for macos
        nix-darwin.url = "github:lnl7/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

        # home-manager: user environment and dotfile management with nix
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # flake-parts and nixos-flakes: unify home manager, nixos and darwin
        flake-parts.url = "github:hercules-ci/flake-parts";
        nixos-flake.url = "github:srid/nixos-flake";

        # dev toolchain
        rust-overlay.url = "github:oxalica/rust-overlay";
        rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, ... }:
        inputs.flake-parts.lib.mkFlake { inherit inputs; } {
            systems = [ "x86_64-linux" "x86_64-darwin" ];
            imports = [
                inputs.nixos-flake.flakeModule
                ./users
                ./modules
                ./home
            ];

            flake = {
                # linux
                nixosConfigurations = {
                    # my macbook on nixos
                    circe = self.nixos-flake.lib.mkLinuxSystem {
                        imports = [
                            self.nixosModules.common
                            self.nixosModules.linux
                            ./hosts/circe/default.nix
                        ];
                    };
                };

                # macos
                darwinConfigurations = {
                    # my macbook
                    eve = self.nixos-flake.lib.mkIntelMacosSystem {
                        imports = [
                            self.nixosModules.common
                            self.nixosModules.darwin
                            ./hosts/eve/default.nix
                        ];
                    };
                };
            };

            perSystem = { self', inputs', system, pkgs, ... }:
                (import ./dev/rust.nix {inherit inputs system pkgs;});
        };
}
