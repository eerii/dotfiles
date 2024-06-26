{ lib, config, ... }:
{
  options.steam.enable = lib.mkEnableOption "enable steam";

  # Steam should be enabled on the system level since it needs to change the environment
  config = lib.mkIf config.steam.enable {
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
