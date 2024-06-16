{
  sys,
  lib,
  config,
  ...
}:
let
  home = config.home.homeDirectory;
  inherit (lib) mkDefault;
in
{
  # User specific configuration
  imports = [ ./${sys.username}.nix ];

  # Modules enabled by default
  easyeffects.enable = mkDefault true;
  fish.enable = mkDefault true;
  foot.enable = mkDefault true;
  neovim.enable = mkDefault true;
  pass.enable = mkDefault true;
  wayland.enable = mkDefault true;

  # XDG configuration
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      documents = "${home}/Documentos";
      download = "${home}/Descargas";
      desktop = "${home}/Descargas";
      pictures = "${home}/Imagenes";
      music = "${home}/Videos";
      videos = "${home}/Videos";
      publicShare = null;
      templates = null;
      extraConfig = {
        XDG_CODE_DIR = "${home}/Code";
      };
    };
  };

  # Impermanence
  persistence.dirs = [
    "Documentos"
    "Imagenes"
    "Videos"
    {
      directory = "Code";
      method = "symlink"; # Works more reliably for building code
    }
  ];
}
