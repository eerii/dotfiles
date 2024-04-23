{ lib, config, ... }:
with lib; {
  options = { neovim.enable = mkEnableOption "enable neovim"; }; 

  config = mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    home.sessionVariables.EDITOR = "nvim";
  };
}
