{
  # Nix daemon settings
  # Activates the flake and nix experimental features
  # Also enables garbage cleaning and optimization
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
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
