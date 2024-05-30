{ extra, ... }:
{
  imports = extra.importFiles ./.;

  persistence.dirs = [
    {
      directory = ".local/share/Steam";
      method = "symlink";
    }
    # ".steam"
  ];
}
