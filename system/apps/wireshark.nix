{ lib, config, ... }:
{
  options.wireshark.enable = lib.mkEnableOption "enable wireshark";

  config = lib.mkIf config.wireshark.enable { programs.wireshark.enable = true; };
}
