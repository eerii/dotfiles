{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    movies.enable = lib.mkEnableOption "enable movies";
  };

  config = lib.mkIf config.movies.enable {
    home.packages = with pkgs; [
      stremio # watch movies and shows
      celluloid # mvp frontend
      parabolic # download videos
      # footage # quickly edit videos
    ];

    persistence.dirs = [ ".local/share/Smart Code ltd/Stremio" ];
  };
}
