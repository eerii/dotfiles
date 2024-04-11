{ sys, ... }: {
  # User specific configuration
  imports = [ ./${sys.username}.nix ];

  # Root password
  users.users.root.hashedPasswordFile = "/persist/passwd/root";
}
