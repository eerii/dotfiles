{ sys, lib, ... }:
{
  networking = {
    # Hostname
    hostName = sys.hostname;

    # Network manager
    networkmanager.enable = true;

    # Firewall
    firewall.enable = lib.mkDefault true;

    # Hosts file
    extraHosts = "";
  };
}
