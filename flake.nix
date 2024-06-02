{
  description = "eri's dots";

  # Inputs defines the dependencies of this flake
  inputs = {
    # Nix Community Fork, https://aux.computer
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # System
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swayfx = {
      url = "github:/WillPower3309/swayfx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # User repo
    nur.url = "github:nix-community/NUR";
  };

  # Outputs returns an attribute set with the system configuration
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      extra = import ./lib { inherit lib; };
      sys = import ./hosts/mksystem.nix { inherit inputs extra lib; };
    in
    {
      # Host configurations
      # Add each host here and a configuration will be created
      # The system modules are located in hosts/name
      # The home configuration is per user
      nixosConfigurations = {
        # My main laptop
        nyx = sys.mkSystem {
          username = "eri";
          hostname = "nyx";
          device = "/dev/nvme0n1";
          swap = "32G";
          extraModules = [ inputs.nixos-hardware.nixosModules.framework-16-7040-amd ];
        };
      };
    };
}
