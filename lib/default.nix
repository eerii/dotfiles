{ lib, ... }:
{
  # Let the path be relative to the project root
  fromRoot = lib.path.append ../.;

  # Get all the nix files in the current directory (excluding default.nix)
  importFiles =
    path:
    map (f: (path + "/${f}")) # .
      (
        lib.attrNames (
          lib.attrsets.filterAttrs (
            path: dir:
            (dir == "directory") # Include directories
            || (
              (path != "default.nix") # Ignore default.nix
              && (lib.strings.hasSuffix ".nix" path) # Include .nix files
            )
          ) (builtins.readDir path)
        )
      );
}
