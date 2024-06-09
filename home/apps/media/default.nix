{ pkgs, extra, ... }:
{
  imports = extra.importFiles ./.;

  home.packages = with pkgs; [
    localsend # share files
    fragments # torrent
    foliate # ebook reader
  ];
}
