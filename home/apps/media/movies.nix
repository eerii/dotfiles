{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options = {
    movies.enable = mkEnableOption "enable movies";
  };

  config = mkIf config.movies.enable {
    home.packages = with pkgs; [
      stremio # watch movies and shows
      celluloid # mvp frontend
      parabolic # download videos
      # footage # quickly edit videos
    ];

    persistence.dirs = [ ".local/share/Smart Code ltd/Stremio" ];
  };
}
