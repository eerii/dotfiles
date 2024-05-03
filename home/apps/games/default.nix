{ lib, osConfig, ... }:
with lib;
{
  config = mkIf osConfig.steam.enable {
    # Impermanence
    home.persistence."/persist/home/${sys.username}".directories = [
      ".local/share/Steam"
      ".steam"
    ];
  };
}
