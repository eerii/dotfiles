{ sys, config, ...}:
let home = config.home.homeDirectory;
in {
  # User specific configuration
  imports = [ ./${sys.username}.nix ];

  # XDG configuration
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      documents = "${home}/Documentos";
      download = "${home}/Descargas";
      desktop = "${home}/Descargas";
      pictures = "${home}/Imágenes";
      music = "${home}/Videos";
      videos = "${home}/Videos";
      publicShare = null;
      templates = null;
      extraConfig = { XDG_CODE_DIR = "${home}/Code"; };
    };

    # TODO: Xdg portal
  };
}
