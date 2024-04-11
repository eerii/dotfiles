{ inputs, pkgs, ... }:

{
  # This is the computer specific hardware configuration
  imports = [ ./hardware-configuration.nix ];

  # Enable ssh for this vm
  services.openssh.enable = true;
}
