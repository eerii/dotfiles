{ config, ... }:
let
  home = config.home.homeDirectory;
in
{
  # Enable submodules
  ardour.enable = true;
  aseprite.enable = true;
  blender.enable = true;
  bottles.enable = true;
  cartridges.enable = true;
  darktable.enable = true;
  easyeffects.enable = true;
  firefox.enable = true;
  fish.enable = true;
  foot.enable = true;
  gimp.enable = true;
  gnome-apps.enable = true;
  inkscape.enable = true;
  matrix.enable = true;
  microsoft-fonts.enable = true;
  movies.enable = true;
  neovim.enable = true;
  obs.enable = true;
  office.enable = true;
  pass.enable = true;
  switch.enable = true;
  thunderbird.enable = true;
  wayland.enable = true;

  # Profile picture
  home.file.".face".source = ./eri.jpg;

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
