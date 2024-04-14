{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Archives
    zip

    # Rust POSIX
    bat # cat
    eza # ls
    ripgrep # grep
    zoxide # cd

    # TODO: Enable in 2-3 days Nix
    # nix-inspect
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
