{ lib, config, ... }:
with lib;
{
  options = {
    steam.enable = mkEnableOption "enable steam";
  };

  # Steam should be enabled on the system level since it needs to change the environment
  config = mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
  };
}
