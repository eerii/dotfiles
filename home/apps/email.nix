{
  lib,
  config,
  sys,
  ...
}:
with lib;
{
  options = {
    thunderbird.enable = mkEnableOption "enable thunderbird";
  };

  config = mkIf config.thunderbird.enable {
    # Email client
    # TODO: Add email accounts
    # TODO: Persistence
    # TODO: Calendars
    programs.thunderbird = {
      enable = true;
      profiles.${sys.username} = {
        isDefault = true;
      };
    };
  };
}
