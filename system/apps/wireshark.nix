{
  lib,
  config,
  sys,
  pkgs,
  ...
}:
{
  options.wireshark.enable = lib.mkEnableOption "enable wireshark";

  config = lib.mkIf config.wireshark.enable {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };

    users.users.${sys.username}.extraGroups = [ "wireshark" ];
    users.groups.wireshark.gid = 500;
  };
}
