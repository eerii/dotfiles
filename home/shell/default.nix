{ extra, pkgs, ... }:
{
  imports = extra.importFiles ./.;

  # Shell utils
  home.packages = with pkgs; [
    zip
    unzip

    bat # cat
    bottom # ps
    eza # ls
    fd # find
    ripgrep # grep
    rm-improved # rm
    zoxide # cd
    # TODO: du/dust/ncu

    aria2 # downloads

    nix-inspect # see nix derivations

    cool-retro-term # cool shell to use sometimes
  ];

  # Jump between directories
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Impermanence
  persistence.dirs = [ ".local/share/zoxide" ];
}
