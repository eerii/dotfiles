{ inputs, system, pkgs, ... }:
let
    overlays = [ (import inputs.rust-overlay) ];
    pkgs = import inputs.nixpkgs {
        inherit system overlays;
    };
in  {
    devenv.shells.rust = {
        packages = with pkgs; [ rust-bin.stable.latest.default ];
        enterShell = "";
    };
}
