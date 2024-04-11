{ pkgs, ... }: {
  # System packages
  # The main packages are handled per user, but these are absolutely needed for the system
  environment.systemPackages = with pkgs;
    [
        vim
        git
    ];
}
