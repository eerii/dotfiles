{
  lib,
  config,
  sys,
  ...
}:
{
  options.waydroid.enable = lib.mkEnableOption "enable waydroid";

  # waydroid should be enabled on the system level
  config = lib.mkIf config.waydroid.enable {
    virtualisation.waydroid.enable = true;

    # disable it at startup
    systemd.services.waydroid-container.wantedBy = lib.mkForce [ ];

    environment.persistence."/persist".directories = [
      "/var/lib/waydroid"
      "/home/${sys.username}/.local/share/waydroid"
    ];
  };
}
