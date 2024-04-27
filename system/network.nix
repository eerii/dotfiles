{ sys, ... }:
{
  # Hostname
  networking.hostName = sys.hostname;

  # Network manager
  networking.networkmanager.enable = true;
}
