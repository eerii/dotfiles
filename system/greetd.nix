{ pkgs, flake, ... }:
{
    services.greetd = {
        enable = true;
        restart = false;

        settings = {
	   # TODO: Configure a login manager	    
           default_session = {
                command = "${pkgs.hyprland}/bin/Hyprland";
                user = "eko";
            };
        };
    };
}
