{
  lib,
  config,
  inputs,
  ...
}:
let
  unpkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  options.aseprite.enable = lib.mkEnableOption "enable aseprite";

  config = lib.mkIf config.aseprite.enable {
    home.packages = with unpkgs; [ aseprite ];

    persistence.dirs = [ ".config/aseprite" ];
  };
}
