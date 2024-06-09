{
  # Keychain (alternative to gnome keyring)
  programs.keychain = {
    enable = true;
    agents = [ "ssh" ];
    keys = [
      "id_rsa"
      "github"
      "gitlab"
      "oracle-cinemazarelos"
    ];
    # These don't actually disable the program, but they make the shell load faster
    enableBashIntegration = false;
    enableFishIntegration = false;
  };
}
