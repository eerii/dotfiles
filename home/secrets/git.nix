{
  # Enable git configuration
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "eri";
    userEmail = "eri@inventati.org";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  # Keep specific repos in sync
  # Configure them with git-sync.repositories.*
  services.git-sync.enable = true;
}
