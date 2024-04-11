{ pkgs, inputs, ... }:

{
  # Import relevant modules
  imports = [
    # NOTE: This depends on each computer, so modify it
    ./hardware-configuration.nix
    # Recreate the root on every boot
    ./impermanence
    # Use home manager to manage the user packages
    inputs.home-manager.nixosModules.default
  ];

  # Nix related configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  system.stateVersion = "24.05";

  # Bootloader
  boot.loader.grub.enable = true;

  # Locale
  time.timeZone = "Europe/Madrid";

  # Network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  services.openssh.enable = true;

  # System packages
  # The main packages are handled per user, but these are absolutely needed for the system
  environment.systemPackages = with pkgs; [ vim git ];

  # Users and home
  # NOTE: Passwords must be coppied manually in a hashed file to the persist directory
  #       They can be generated using mkpasswd
  users.users = {
    root.hashedPasswordFile = "/persist/passwd/root";
    eri = {
      hashedPasswordFile = "/persist/passwd/eri";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "eri" = import ../../home; };
  };
}
