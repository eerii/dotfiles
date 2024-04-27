{ lib, ... }:
with lib;
with builtins;
{
  # Let the path be relative to the project root
  fromRoot = path.append ../.;

  # Get all the nix files in the current directory (excluding default.nix)
  importFiles =
    path:
    map (f: (path + "/${f}")) # .
      (
        attrNames (
          attrsets.filterAttrs (
            path: dir:
            (dir == "directory") # Include directories
            || (
              (path != "default.nix") # Ignore default.nix
              && (strings.hasSuffix ".nix" path) # Include .nix files
            )
          ) (readDir path)
        )
      );
}
