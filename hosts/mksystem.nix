{
  inputs,
  extra,
  lib,
  ...
}:
with lib;
{
  # System settings
  #   - username: The name of the main user
  #   - hostname: The hostname of the configuration
  #   - device: The disk that should be formatted, something like /dev/sda
  #   - extraModules: Extra configuration to pass to to the config
  #   - timezone: Local timezone of the system
  #   - locale: Default language of the system
  #   - impermanence: Whether to enable impermanence
  #   - swap: Swap size
  #   - homeManager: Whether to enable home manager
  mkSystem =
    {
      username,
      hostname,
      device,
      extraModules ? [ ],
      ...
    }@sys:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs extra sys;
      };
      modules =
        [
          # Package overlays
          {
            nixpkgs.overlays = [
              inputs.nur.overlay
	      inputs.nix-your-shell.overlays.default
            ];
          }
          # Per host configuration
          ./${hostname}
          # Default system modules
          ../system
        ]
        ++ (optionals sys.homeManager or true [
          # Use home manager to manage the user packages
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = {
                imports = [ ../home ];
              };
              extraSpecialArgs = {
                inherit inputs extra sys;
              };
            };
          }
        ])
        ++ extraModules;
    };
}
