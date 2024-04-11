{ inputs, ... }:

{
  imports = [
    # Impermanence module
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  # Home manager configuration
  home.stateVersion = "24.05";

  # User programs
  programs.neovim.enable = true;

  # Impermanence setup
  # NOTE: Everything that is not specified here or in the impermanence configuration will be wiped!
  home.persistence."/persist/home" = {
    directories = [
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      # "Code"
      "Downloads"
      # ".gnupg"
      # ".ssh"
      # ".nixops"
      # ".local/share/keyrings"
      # ".local/share/direnv"
    ];
    files = [ ];
    allowOther = true;
  };
}
