{
  # Enable git configuration
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "eri";
    userEmail = "eri@inventati.org";
    extraConfig = {
      push.autoSetupRemote = true;
      credential.helper = "keychain";
    };
  };

  # GitHub helper for HTTPS repos
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  persistence.dirs = [ ".config/gh" ];

  # Keep specific repos in sync
  # Configure them with git-sync.repositories.*
  # services.git-sync.enable = true;
}
