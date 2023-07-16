{ lib, pkgs }:
pkgs.stdenvNoCC.mkDerivation rec {
    pname = "sf-mono-nerd";
    version = "dc5a3e6fcc2e16ad476b7be3c3c17c2273b260ea";
  
    src = pkgs.fetchFromGitHub {
        owner = "shaunsingh";
        repo = "SFMono-Nerd-Font-Ligaturized";
        rev = version;
        sha256 = "sha256-AYjKrVLISsJWXN6Cj74wXmbJtREkFDYOCRw1t2nVH2w=";
    };

    dontConfigure = true;
    installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp -R $src/*.otf $out/share/fonts/opentype
    '';

    meta = with lib; {
        description = "SF Mono (Nerd)";
        longDescription = "Beatiful Mono Font (Made in California, Hacked By Nerd).";
        homepage = "https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized";
        license = licenses.unfree;
        platforms = platforms.all;
    };
}
