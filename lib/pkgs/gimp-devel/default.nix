{ pkgs, inputs }:
pkgs.callPackage (
  {
    stdenv,
    lib,
    aalib,
    alsa-lib,
    appstream,
    appstream-glib,
    babl,
    bashInteractive,
    cairo,
    desktop-file-utils,
    findutils,
    gdk-pixbuf,
    gegl,
    gexiv2,
    ghostscript,
    gi-docgen,
    gjs,
    glib,
    glib-networking,
    gobject-introspection,
    gtk3,
    isocodes,
    lcms,
    libarchive,
    libgudev,
    libheif,
    libjxl,
    libmng,
    libmypaint,
    librsvg,
    libwebp,
    libwmf,
    libxslt,
    luajit,
    meson,
    qoi,
    cfitsio,
    mypaint-brushes1,
    ninja,
    openexr,
    perl538,
    pkg-config,
    poppler,
    poppler_data,
    python3,
    shared-mime-info,
    vala,
    wrapGAppsHook,
    xorg,
    xvfb-run,

  }:
  let
    python = python3.withPackages (pp: [ pp.pygobject3 ]);
    lua = luajit.withPackages (ps: [ ps.lgi ]);
  in
  stdenv.mkDerivation (finalAttrs: {
    pname = "gimp";
    version = "2.99.19";

    outputs = [
      "out"
      "dev"
    ];

    src = inputs.gimp;

    patches = [
      ./meson-gtls.diff
      ./pygimp-interp.diff
      ./splash.diff
    ];

    nativeBuildInputs = [
      pkg-config
      libxslt
      ghostscript
      libarchive
      bashInteractive
      libheif
      libwebp
      libmng
      aalib
      libjxl
      isocodes
      perl538
      appstream
      meson
      xvfb-run
      gi-docgen
      findutils
      vala
      alsa-lib
      ninja
      wrapGAppsHook
    ];

    buildInputs = [
      gjs
      lua
      qoi
      babl
      appstream-glib
      gegl
      gtk3
      glib
      gdk-pixbuf
      cairo
      gexiv2
      lcms
      libjxl
      cfitsio
      poppler
      poppler_data
      openexr
      libmng
      librsvg
      desktop-file-utils
      libwmf
      ghostscript
      aalib
      shared-mime-info
      libwebp
      libheif
      xorg.libXpm
      xorg.libXmu
      glib-networking
      libmypaint
      mypaint-brushes1
      gobject-introspection
      python
      libgudev
    ];

    prePatch = ''
      # Workaround because submodules don't seem to work
      rm -rf gimp-data
      cp -r ${inputs.gimp-data} gimp-data
      find gimp-data -type f | xargs chmod -v 644
      find gimp-data -type d | xargs chmod -v 755

      # Fix some paths
      mkdir -p $out/share/locale
    '';

    preConfigure = "patchShebangs tools plug-ins app/tests/create_test_env.sh";

    HOME = "/home/eri";

    mesonFlags = [ "-Dilbm=disabled" ];

    enableParallelBuilding = true;

    doCheck = false;

    meta = with lib; {
      description = "The GNU Image Manipulation Program: Development Edition";
      homepage = "https://www.gimp.org/";
      license = licenses.gpl3Plus;
      platforms = platforms.unix;
      mainProgram = "gimp";
    };
  })
) { }
