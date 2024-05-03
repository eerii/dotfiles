{ sys, ... }:
{
  # User specific configuration
  imports = [ ./${sys.username}.nix ];

  # Root password
  users.users.root.hashedPasswordFile = "/persist/passwd/root";

  # Further ensure that sudo can only be used by wheel users
  security.sudo.execWheelOnly = true;
}
