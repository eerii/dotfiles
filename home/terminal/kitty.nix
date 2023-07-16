{ pkgs, ... }:

{
    programs = {
        kitty = {
            enable = true;

            font.name = "Liga SFMono Nerd Font";
            font.size = 13;

	    theme = "Rosé Pine";

            settings = {
		scrollback_lines = 10000;

	    	macos_titlebar_color = "background";
		macos_quit_when_last_window_closed = "yes";
            };

            extraConfig = '' '';
        };
    };
}
