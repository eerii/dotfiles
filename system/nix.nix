{
  # Nix daemon settings
  # Activates the flake and nix experimental features
  # Also enables garbage cleaning and optimization
  nix = {
    # Enable flakes and optimisations
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      warn-dirty = false;
    };

    # Restrict the nix daemon to the sudoers
    # This can prevent atackers from doing shady things with the package manager
    settings.allowed-users = [ "@wheel" ];

    # Garbage clean each week to keep the system light
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    # Use Aux, a community fork of Nix
    registry.nixpkgs = {
      from = {
        id = "nixpkgs";
        type = "indirect";
      };
      to = {
        owner = "auxolotl";
        repo = "nixpkgs";
        type = "github";
      };
    };
  };

  # Don't change this
  system.stateVersion = "24.05";
}
