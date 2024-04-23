{ pkgs, lib, config, ... }: with lib; {
  options = { movies.enable = mkEnableOption "enable movies"; };

  config = mkIf config.movies.enable {
    home.packages = with pkgs; [
      stremio 
    ];
  };
}
