{ inputs, ... }:
{
  overlays.default = final: prev: {
    # Gimp 2.99
    gimp-devel = import ./gimp-devel {
      inherit inputs;
      pkgs = prev;
    };

    # Beaver notes
    beaver-notes = import ./beaver-notes {
      inherit inputs;
      pkgs = prev;
    };
  };
}
