{ sys, ... }:
{
  networking = {
    # Hostname
    hostName = sys.hostname;

    # Network manager
    networkmanager.enable = true;

    # Firewall
    firewall.enable = true;
  };
}
