{
  inputs,
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

        settings = {
          "widget.wayland.fractional-scale.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
        };

        userChrome = ''
          @import "thunderbird-gnome-theme/userChrome.css";
        '';

        userContent = ''
          @import "thunderbird-gnome-theme/userContent.css";
        '';
      };
    };

    # GTK Theme
    home.file."thunderbird-gnome-theme" = {
      target = ".thunderbird/${sys.username}/chrome/thunderbird-gnome-theme";
      source = inputs.thunderbird-gnome-theme;
    };

    persistence.dirs = [ ".thunderbird/${sys.username}" ];
  };
}
