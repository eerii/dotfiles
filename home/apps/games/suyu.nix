{
  inputs,
  lib,
  config,
  ...
}:
{
  options = {
    switch.enable = lib.mkEnableOption "enable switch";
  };

  config = lib.mkIf config.switch.enable {
    home.packages = [ inputs.suyu.packages."x86_64-linux".default ];

    persistence.dirs = [
      ".local/share/suyu"
      ".config/suyu"
    ];
  };
}
