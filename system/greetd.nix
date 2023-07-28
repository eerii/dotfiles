{ pkgs, ... }:
let
    hyprland-kiosk = pkgs.writeShellScriptBin "hyprland-kiosk" ''
        export XDG_SESSION_TYPE=wayland
        export XCURSOR_THEME=Bibata-Modern-Classic
        export XCURSOR_SIZE=24
        exec ${pkgs.hyprland}/bin/Hyprland --config /etc/greetd/hyprland.conf
    '';
in
{
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${hyprland-kiosk}/bin/hyprland-kiosk";
                user = "greeter";
            };
        };
    };

    programs.regreet = {
        enable = true;
        settings = {
            
        };
    };

    environment.systemPackages = with pkgs; [
        hyprland-kiosk
        greetd.regreet
    ];

    environment.etc = {
        "greetd/environments".text = "zsh";
        "greetd/hyprland.conf".text = ''
            monitor = , preferred, auto, auto
            misc {
                disable_hyprland_logo = true
            }
            input {
                kb_layout = es
            }
            exec = systemd-cat --identifier=regreet ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit ""
        '';
    };
}
