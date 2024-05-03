{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  dir = config.home.homeDirectory + "/.password-store";
in
{
  options = {
    pass.enable = mkEnableOption "enable password store";
  };

  config = mkIf config.pass.enable {
    # Use password store as a secret manager
    programs.password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: with exts; [ pass-otp ]);
      settings.PASSWORD_STORE_DIR = dir;
    };

    # Sync the pass repo every hour
    # For this to work ssh keys must be configured propperly
    services.git-sync.repositories.password-store = {
      path = dir;
      uri = "git@github.com:eerii/pass.git";
      interval = 3600;
    };
  };
}