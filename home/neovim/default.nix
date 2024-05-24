{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
with lib;
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  neovim-nightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
in
{
  options = {
    neovim.enable = mkEnableOption "enable neovim";
  };

  config = mkIf config.neovim.enable {
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
      nodePackages.bash-language-server

      # Formatters
      stylua
      rustfmt
      nodePackages.prettier
      black
      nixfmt-rfc-style
    ];

    # Symlink the lua config to the appropiate place (i'm not migrating it lol)
    home.file."${config.xdg.configHome}/nvim" = {
      source = mkOutOfStoreSymlink ./.;
      recursive = true;
    };

    # Just in case set the editor here as well
    home.sessionVariables.EDITOR = "nvim";
  };
}
