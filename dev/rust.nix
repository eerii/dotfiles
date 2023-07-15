{ inputs, system, pkgs, ... }:
let
    overlays = [ (import inputs.rust-overlay) ];
    pkgs = import inputs.nixpkgs {
        inherit system overlays;
    };
in  {
    devShells.rust = pkgs.mkShell {
        packages = with pkgs; [ rust-bin.stable.latest.default ];
        shellHook = "";
    };
}
