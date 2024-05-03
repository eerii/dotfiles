{
  extra,
  pkgs,
  sys,
  ...
}:
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

    aria2 # downloads

    nix-inspect # see nix derivations
  ];

  # Jump between directories
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Impermanence
  home.persistence."/persist/home/${sys.username}".directories = [ ".local/share/zoxide" ];
}