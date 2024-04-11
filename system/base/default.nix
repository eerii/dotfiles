{ extra, sys, ... }: {
  imports = extra.importFiles ./.;

  # Hostname
  networking.hostName = sys.hostname;

  # Time zone
  time.timeZone = sys.timezone or "Europe/Madrid";

  # Default locale
  i18n.defaultLocale = sys.locale or "es_ES.UTF-8";
}
