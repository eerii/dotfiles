{
  extra,
  sys,
  lib,
  pkgs,
  ...
}:
with lib;
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
  programs.light.enable = true;
  users.users.${sys.username}.extraGroups = [ "video" ];

  # Dconf
  programs.dconf.enable = true;
}
