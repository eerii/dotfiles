{ pkgs, ... }: {
  # NOTE: Passwords must be coppied manually in a hashed file to the persist directory
  #       They can be generated using mkpasswd
  # TODO: Encrypt with age on the persist folder
  users.users.eri = {
    hashedPasswordFile = "/persist/passwd/eri";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # Login shell
  # Fish is configured in home manager but it needs to be enabled here as well
  programs.fish.enable = true;
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
