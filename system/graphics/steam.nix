{
  lib,
  config,
  sys,
  ...
}:
with lib;
with builtins;
{
  options.steam.enable = mkEnableOption "enable steam";

  # Steam should be enabled on the system level since it needs to change the environment
  config = mkIf config.steam.enable {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
      ];

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
  };
}
