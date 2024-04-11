{
  description = "eri's dots";

  # Inputs defines the dependencies of this flake
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
  };

  # Outputs returns an attribute set with the system configuration
  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      extra = import ./lib { inherit lib; };
      sys = import ./hosts/mksystem.nix { inherit inputs extra; };
    in {
      # Host configurations
      # Add each host here and a configuration will be created
      # The system modules are located in hosts/name
      # The home configuration is per user
      nixosConfigurations = {
        nixos = sys.mkSystem {
          username = "eri";
          hostname = "nixos";
          device = "/dev/sda";
        };
      };
    };
}
