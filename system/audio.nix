{
  # Enable pipewire for everything
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Disable pulseaudio (since it's already handled by pipewire)
  hardware.pulseaudio.enable = false;
}
