{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    switch.enable = lib.mkEnableOption "enable switch";
  };

  config = lib.mkIf config.switch.enable {
    home.packages = with pkgs.nur.repos.chigyutendies; [ suyu-dev ];
  };
}
