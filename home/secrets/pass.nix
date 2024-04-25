{ pkgs, lib, config, ... }:
with lib;
let dir = config.home.homeDirectory + "/.password-store";
in {
  options = { pass.enable = mkEnableOption "enable password store"; };

  config = mkIf config.pass.enable {
    programs.password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: with exts; [ pass-otp ]);
      settings.PASSWORD_STORE_DIR = dir;
    };

    services.git-sync.repositories.password-store = {
      path = dir;
      uri = "git@github.com:eerii/pass.git";
      interval = 3600;
    };
  };
}
