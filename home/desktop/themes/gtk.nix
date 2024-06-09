{ pkgs, config, ... }:
{
  # GTK
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 12;
    };

    # cursorTheme = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Ice";
    #   size = 20;
    # };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  # QT
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita";
    style.package = pkgs.adwaita-qt;
  };
}
