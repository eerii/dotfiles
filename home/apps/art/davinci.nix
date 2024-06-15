{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  unpkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  davinci-resolve-studio = unpkgs.davinci-resolve-studio.overrideAttrs (old: {
    # preFixup =
    #   (old.preFixup or "")
    #   + ''
    #     # ${pkgs.perl} -pi -e magic... /opt/resolve/bin/resolve
    #   '';
  });
in
{
  options.davinci.enable = lib.mkEnableOption "enable davinci";

  # TODO: Not working yet
  # I don't want to change the rocm version to 5 so let's wait for davinci 19 to see if it resolves it
  config = lib.mkIf config.davinci.enable { home.packages = [ davinci-resolve-studio ]; };
}
