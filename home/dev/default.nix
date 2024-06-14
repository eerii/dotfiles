{ pkgs, extra, ... }:
{
  imports = extra.importFiles ./.;

  home.packages = with pkgs; [
    # Declarative development environments
    devenv

    # Make and GCC for system-wide tool support
    gnumake
    gcc

    # Python
    # This is a system-wide python that is only meant for convenience and running scripts
    # Projects should have their own shell with python packages
    python3
  ];

  # Create per folder development environments with .envrc
  programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
  };

  persistence.dirs = [ ".local/share/direnv" ];
}
