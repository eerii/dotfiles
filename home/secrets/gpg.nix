{ pkgs, sys, ... }:
{
  # Enable gpg agent
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Impermanence
  home.persistence."/persist/home/${sys.username}".directories = [
    ".gnupg"
    ".ssh"
    ".local/share/keyrings"
  ];
}
