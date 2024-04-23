{
  programs.git = {
    enable = true;
    userName = "eri";
    userEmail = "eri@inventati.org";
  };

  # keep specific repos in sync
  # configure them with git-sync.repositories.*
  services.git-sync.enable = true;
}
