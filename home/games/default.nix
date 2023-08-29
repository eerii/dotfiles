{ pkgs, ... }:
{
    home.packages = with pkgs; [
        bottles
        (steam.override { withJava = true; }) # just steam launch
        (lutris.override {
            extraLibraries = pkgs: [
                # extra dependencies 
            ];
        })
        # steamtinkerlaunch
    ];
    
    programs.java.enable = true;

    # full steam client
    /* programs.steam = {
        enable = true;
        withJava = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    }; */

    # mgba
    # mupen64plus
    # melonds
    # dolphin
    # citra
}
