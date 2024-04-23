{ lib, config, pkgs, sys, ... }:
with lib; {
  options = { firefox.enable = mkEnableOption "enable firefox"; };

  config = mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      #policies = {};
      profiles.${sys.username} = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          adnauseam
          sponsorblock
          duckduckgo-privacy-essentials
          return-youtube-dislikes
          refined-github
        ];
      };
    };
  };
}
