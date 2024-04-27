{
  lib,
  config,
  sys,
  ...
}:
with lib;
with builtins;
{
  options = {
    easyeffects.enable = mkEnableOption "enable easyeffects";
  };

  config = mkIf config.easyeffects.enable {
    # Enable easyeffecs (an audio equalizer)
    services.easyeffects = {
      enable = true;
      preset = sys.hostname;
    };

    # Framework 16 easy effects profile
    home.file."${config.xdg.configHome}/easyeffects/output/nyx.json".source = fetchurl {
      url = "https://gist.githubusercontent.com/amesb/cc5d717472d7e322b5f551b643ff03f4/raw/85029e48072ab3802615b2824dce7df204f0d8ab/amesb%2520fw16%2520EE%2520profile.json";
      name = "nyx.json";
      sha256 = "1j432lqrhyqk2p7aib5yfj6c67s8lr75hffrp36zzr067gs15vsd";
    };
  };
}
