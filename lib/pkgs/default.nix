{ inputs, ... }:
{
  overlays.default = final: prev: {
    # Gimp 2.99
    gimp-devel = import ./gimp-devel { pkgs = prev; };
  };
}
