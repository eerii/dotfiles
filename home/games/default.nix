{ pkgs, ... }:
{
    home.packages = with pkgs; [
        (lutris.override {
            extraLibraries = pkgs: [
                # extra dependencies 
            ];
        })
        # steamtinkerlaunch
    ];
}
