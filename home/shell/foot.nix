{ lib, config, ... }:
with lib;
{
  options = {
    foot.enable = mkEnableOption "enable foot";
  };

  config = mkIf config.foot.enable {
    # Foot terminal (simple and fast wayland term)
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "Jetbrains Mono:size=11, Symbols Nerd Font Mono:size=10";
          line-height = "16px";
          pad = "6x6 center";
        };
        colors = {
          background = "0B0E14";
        };
        scrollback = {
          lines = "10000";
        };
        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
          search-start = "Control+s";
          scrollback-up-half-page = "Control+u";
          scrollback-down-half-page = "Control+d";
          scrollback-home = "Control+g";
          scrollback-end = "Control+f";
        };
        text-bindings = {
          "x03" = "Mod4+c"; # Map Super+c -> Ctrl+c
        };
        search-bindings = {
          find-next = "Control+n";
          find-prev = "Control+p";
        };
      };
    };
  };
}
