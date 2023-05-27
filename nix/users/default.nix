{ config, lib, ... }:
let
    # user config fields
    userSubmodule = lib.types.submodule {
        options = {
            name = lib.mkOption {
                type = lib.types.str;
                description = "User full name";
            };
            email = lib.mkOption {
                type = lib.types.str;
                description = "User email";
            };
            sshKeys = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                description = "SSH public keys";
            };
        };
    };

    # list of users
    usersSubmodule = lib.types.submodule {
        options = {
            users = lib.mkOption {
                type = lib.types.attrsOf userSubmodule;
                description = "List of system users";
            };
            me = lib.mkOption {
                type = lib.types.str;
                description = "The name of the user that represents me";
            };
        };
    };
in
{
    options = {
        users = lib.mkOption {
            type = usersSubmodule;
        };
    };

    # add users to flake config
    config = {
        users = import ./config.nix;
    };
}
