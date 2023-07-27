{ pkgs, ... }:
{
    programs.password-store = {
        enable = true;
        # TODO: wayland package
        settings = {
            PASSWORD_STORE_DIR = "$HOME/.password-store";
        };
    };
}
