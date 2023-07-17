{ lib, pkgs }: with pkgs;
stdenv.mkDerivation rec {
    pname = "apple-fonts";
    version = "1";

    pro = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
        sha256 = null;
    };

    compact = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
        sha256 = null;
    };

    mono = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
        sha256 = null;
    };

    ny = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
        sha256 = null;
    };

    nativeBuildInputs = [ p7zip ];

    sourceRoot = ".";

    dontUnpack = true;

    installPhase = ''
        7z x ${pro}
        cd SFProFonts 
        7z x 'SF Pro Fonts.pkg'
        7z x 'Payload~'
        mkdir -p $out/fontfiles
        mv Library/Fonts/* $out/fontfiles
        cd ..

        7z x ${mono}
        cd SFMonoFonts
        7z x 'SF Mono Fonts.pkg'
        7z x 'Payload~'
        mv Library/Fonts/* $out/fontfiles
        cd ..

        7z x ${compact}
        cd SFCompactFonts
        7z x 'SF Compact Fonts.pkg'
        7z x 'Payload~'
        mv Library/Fonts/* $out/fontfiles
        cd ..

        7z x ${ny}
        cd NYFonts
        7z x 'NY Fonts.pkg'
        7z x 'Payload~'
        mv Library/Fonts/* $out/fontfiles

        mkdir -p $out/share/fonts/OTF $out/share/fonts/TTF
        mv $out/fontfiles/*.otf $out/share/fonts/OTF
        mv $out/fontfiles/*.ttf $out/share/fonts/TTF
        rm -rf $out/fontfiles
    '';

    meta = with lib; {
        description = "Apple San Francisco Fonts";
        homepage = "https://developer.apple.com/fonts/";
        license = licenses.unfree;
        platforms = platforms.all;
    };
}
