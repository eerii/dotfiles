{ inputs, extra, ... }: {
  # System settings
  #   - username: The name of the main user
  #   - hostname: The hostname of the configuration
  #   - device: The disk that should be formatted, something like /dev/sda
  #   - extraModules: Extra configuration to pass to to the config
  #   - timezone: Local timezone of the system
  #   - locale: Default language of the system
  mkSystem = { username, hostname, device, extraModules ? [ ], ... }@sys:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs extra sys; };
      modules = [
        # Package overlays
        {
          nixpkgs.overlays = [ inputs.nur.overlay ];
        }
        # Use home manager to manage the user packages
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = { imports = [ ../home ]; };
            extraSpecialArgs = { inherit inputs extra sys; };
          };
        }
        # Per host configuration
        ./${hostname}
        # Default system modules
        ../system
      ] ++ extraModules;
    };
}
