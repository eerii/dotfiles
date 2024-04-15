{ lib, config, ... }:
with lib; {
  options = { foot.enable = mkEnableOption "enable foot"; };

  config = mkIf config.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          # TODO: font = "Jetbrains Mono:size=12, Symbols Nerd Font Mono:size=10";
          # TODO: include = "/usr/share/foot/themes/ayu-mirage";
          line-height = "18px";
          pad = "12x8 center";
        };
        colors = { background = "0B0E14"; };
        scrollback = { lines = "10000"; };
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
