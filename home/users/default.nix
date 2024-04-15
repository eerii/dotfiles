{ sys, ...}: {
  # User specific configuration
  imports = [ ./${sys.username}.nix ];
}
