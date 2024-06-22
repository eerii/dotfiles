{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ "${inputs.nextcloud-extras}/nextcloud-extras.nix" ];

  options.nextcloud.enable = lib.mkEnableOption "enable nextcloud";

  config = lib.mkIf config.nextcloud.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud29;

      hostName = "next.conflor.es";
      webserver = "caddy";
      # https = true; (handled in tunnel)

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          bookmarks
          calendar
          contacts
          deck
          forms
          notes
          notify_push
          tasks
          unroundedcorners
          ;
      };
      appstoreEnable = true;

      maxUploadSize = "10G";
      configureRedis = true;
      config.adminpassFile = "/persist/cloud/pass";
    };

    # Web tunnel to expose the network
    systemd.services.rathole = {
      enable = true;
      description = "Rathole tunnel client";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.rathole}/bin/rathole /persist/cloud/rathole.toml";
      };
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
    };
  };
}
