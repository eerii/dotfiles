{
  lib,
  config,
  sys,
  ...
}:
with lib;
{
  options.thunderbird.enable = mkEnableOption "enable thunderbird";

  config = mkIf config.thunderbird.enable {
    # Email client
    # TODO: Add email accounts
    # TODO: Calendars
    programs.thunderbird = {
      enable = true;
      profiles.${sys.username} = {
        isDefault = true;
      };
    };

    persistence.dirs = [ ".thunderbird/${sys.username}" ];
  };
}
