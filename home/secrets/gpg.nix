{ pkgs, sys, ... }:
{
  # Enable gpg agent
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Impermanence
  persistence.dirs = [
    ".gnupg"
    ".ssh"
    ".local/share/keyrings"
  ];
}
