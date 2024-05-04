{
  lib,
  sys,
  osConfig,
  ...
}:
with lib;
{
  config = mkIf osConfig.steam.enable {
    # Impermanence
    persistence.dirs = [
      ".local/share/Steam"
      ".steam"
    ];
  };
}
