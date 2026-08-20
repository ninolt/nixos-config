{ pkgs, lib, ... }:
let
  pname = "joplin-desktop";
  version = "3.7.10";

  src = pkgs.fetchurl {
    url = "https://github.com/laurent22/joplin/releases/download/v${version}/Joplin-${version}.AppImage";
    hash = "sha256-v/1C7mw5RberJL7oVZLf8kcw1iGFxwZcJ+ZJgn2qBRQ=";
  };

  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };

  joplin = pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = pkgs: with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      dbus
      expat
      gdk-pixbuf
      glib
      gtk3
      libdrm
      libnotify
      libGL
      libGLU
      libpulseaudio
      libxkbcommon
      mesa
      nspr
      nss
      pango
      systemd
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxcb
      libxshmfence
    ];

  extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/appimagekit-joplin.desktop \
        $out/share/applications/${pname}.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/1024x1024/apps/joplin.png \
        $out/share/icons/hicolor/1024x1024/apps/joplin.png
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/1024x1024/apps/joplin.png \
        $out/share/pixmaps/joplin.png
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    '';
  };
in {
  home.packages = [ joplin ];
}
