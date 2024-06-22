{
  lib,
  config,
  extra,
  ...
}:
{
  options.aseprite.enable = lib.mkEnableOption "enable aseprite";

  config = lib.mkIf config.aseprite.enable {
    home.packages = with extra.unpkgs; [ aseprite ];

    persistence.dirs = [ ".config/aseprite" ];
  };
}
