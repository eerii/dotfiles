{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  neovim-nightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
  dotfiles = "${config.xdg.userDirs.extraConfig.XDG_CODE_DIR}/dotfiles";
in
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable {
    # Enable neovim and set if as the default editor
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      package = neovim-nightly;
      # Do I need to add treesitter here or does it already work?
      # plugins = with pkgs.vimPlugins; [ ];
    };

    # Manually install lsps here, mason won't work
    home.packages = with pkgs; [
      # LSP
      lua-language-server
      nixd
      rust-analyzer-unwrapped
      taplo

      # Formatters
      stylua
      rustfmt
      nodePackages.prettier
      black
      nixfmt-rfc-style
    ];

    # Symlink the lua config to the appropiate place (i'm not migrating it lol)
    xdg.configFile = {
      "nvim/lazy-lock.json".source = mkOutOfStoreSymlink "${dotfiles}/home/neovim/lazy-lock.json";

      "nvim/init.lua".source = ./init.lua;

      "nvim/lua" = {
        source = mkOutOfStoreSymlink ./lua;
        recursive = true;
      };
    };

    # Just in case set the editor here as well
    home.sessionVariables.EDITOR = "nvim";

    # Impermanence
    persistence.dirs = [
      {
    	directory = ".local/share/nvim";
	method = "symlink";
      }
    ];
  };
}
