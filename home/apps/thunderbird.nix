{ lib, config, pkgs, sys, ... }:
with lib; {
  options = { thunderbird.enable = mkEnableOption "enable thunderbird"; };

  config = mkIf config.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles.${sys.username} = {};
    };
  };
}
