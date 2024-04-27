{
  # This is the computer specific hardware configuration
  imports = [ ./hardware-configuration.nix ];

  # Enable ssh for this vm
  services.openssh.enable = true;

  # Enable modules
  gdm.enable = true;
  gnome.enable = true;

  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
