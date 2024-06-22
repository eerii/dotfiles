{ sys, ... }:
{
  networking = {
    # Hostname
    hostName = sys.hostname;

    # Network manager
    networkmanager.enable = true;

    # Firewall
    firewall.enable = true;

    # Hosts file
    extraHosts = ''
      192.168.1.152 next.conflor.es
    '';
  };
}
