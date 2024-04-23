{ lib, config, ... }:
with lib;
with builtins; {
  options = { easyeffects.enable = mkEnableOption "enable easyeffects"; };

  config = mkIf config.easyeffects.enable {
    services.easyeffects = {
      enable = true;
      preset = readFile (fetchurl {
        # Framework 16 easy effects profile
        url =
          "https://gist.githubusercontent.com/amesb/cc5d717472d7e322b5f551b643ff03f4/raw/85029e48072ab3802615b2824dce7df204f0d8ab/amesb%2520fw16%2520EE%2520profile.json";
      });
    };
  };
}
