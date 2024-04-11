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
  outputs = { nixpkgs, ... }@inputs: {
    # This is a NixOS configuration for the host "nixos"
    # If more hosts are added in the futre they can go here
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/nixos ];
    };
  };
}
