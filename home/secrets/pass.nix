{
  pkgs,
  lib,
  config,
  ...
}:
let
  dir = config.home.homeDirectory + "/.password-store";
in
{
  options = {
    pass.enable = lib.mkEnableOption "enable password store";
  };

  config = lib.mkIf config.pass.enable {
    # Use password store as a secret manager
    programs.password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: with exts; [ pass-otp ]);
      settings.PASSWORD_STORE_DIR = dir;
    };

    persistence.dirs = [ ".password-store" ];
  };
}
