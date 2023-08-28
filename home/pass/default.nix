{ pkgs, ... }:
{
    programs.password-store = {
        enable = true;
        settings = {
            PASSWORD_STORE_DIR = "$HOME/.password-store";
        };
        package = pkgs.pass.withExtensions (es: with es; [
            pass-audit
            pass-import
            pass-otp
            pass-update
        ]);
    };

    programs.browserpass = {
        enable = true;
        browsers = [ "librewolf" ];
    };

    home.sessionVariables = {
        PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    };

    home.file.".password-store/.extensions/age.bash".source = pkgs.fetchFromGitHub {
        owner = "taylorskalyo";
        repo = "pass-age";
        rev = "c568c031332f0a01980b3d87bf2421e95fe1acb2";
        hash = "sha256-Qwu6oUIwY8cyPaqxotfQip24ukALrsVu+t4/mYCTYMs=";
    } + "/age.bash";

    home.packages = with pkgs; [
        pwgen # quickly generate secrets outside of the store
    ];
}
