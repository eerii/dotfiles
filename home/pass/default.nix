{ pkgs, ... }:
{
    programs.password-store = {
        enable = true;
        settings = {
            PASSWORD_STORE_DIR = "$HOME/.password-store";
        };
    };

    home.packages = with pkgs; [
        pwgen # quickly generate secrets outside of the store
    ];
}
