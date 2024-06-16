{
  extra,
  sys,
  lib,
  pkgs,
  ...
}:
{
  imports = extra.importFiles ./.;

  # System packages
  # The main packages are handled per user, but these are pretty much needed for the system
  environment.systemPackages = with pkgs; [
    vim
    git
    just
    foot
  ];

  # Disable the default packages
  environment.defaultPackages = lib.mkForce [ ];

  # Time zone
  time.timeZone = sys.timezone or "Europe/Madrid";

  # Default locale
  i18n.defaultLocale = sys.locale or "es_ES.UTF-8";

  # Polkit (control system wide privileges)
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Brightness
  users.users.${sys.username}.extraGroups = [ "video" ];

  # Dconf
  programs.dconf.enable = true;

  # Virtualization
  virtualisation.spiceUSBRedirection.enable = true;
}
