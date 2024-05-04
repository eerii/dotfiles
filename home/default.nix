{
  extra,
  inputs,
  sys,
  lib,
  config,
  osConfig,
  ...
}:
with lib;
{
  options.persistence = {
    dirs = mkOption {
      default = [ ];
      description = "home persistence directories";
    };
    files = mkOption {
      default = [ ];
      description = "home persistence files";
    };
  };

  # Submodules
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ] ++ extra.importFiles ./.;

  config = {
    # Home manager configuration
    home.stateVersion = "24.05";

    # Impermanence setup
    home.persistence."/persist/home/${sys.username}" = mkIf osConfig.impermanence.enable {
      allowOther = true;
      directories = config.persistence.dirs;
      files = config.persistence.files;
    };
  };
}
