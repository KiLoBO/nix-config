{
  appimageTools,
  fetchurl,
  lib,
  makeDesktopItem,
  stdenvNoCC,
}:

let
  name = pname;
  pname = "winboat";
  version = "0.7.3";

  winboatAppimage = {
    inherit pname version;
    src = fetchurl {
      url = "https://github.com/TibixDev/winboat/releases/download/v${version}/winboat-${version}-x86_64.AppImage";
      hash = "sha256-Jy0OiTOYWzezyOgQe8PZWpi7Hh4q0qJsqWzZzAjxtyQ=";
    };
  };

  icon = "${appimageTools.extract winboatAppimage}/winboat.png";
  winboatWrapped = "sg docker ${appimageTools.wrapType2 winboatAppimage}/bin/winboat";

  desktopItem =
    let
      capitalize =
        string:
        let
          inherit (builtins) stringLength substring;

          firstChar = substring 0 1 string;
          remainingChars = substring 1 (stringLength string - 1) string;
        in
        lib.toUpper firstChar + remainingChars;
    in
    makeDesktopItem {
      inherit icon name;

      categories = [ "Utility" ];
      comment = "Run Windows apps on 🐧 Linux with ✨ seamless integration";
      desktopName = capitalize name;
      exec = winboatWrapped;
    };
in
stdenvNoCC.mkDerivation {
  name = pname;
  dontUnpack = true;

  installPhase =
    let
      winboatBinPath = "$out/bin/winboat";
    in
    ''
      mkdir -p $out/bin
      echo "${winboatWrapped} $@" > ${winboatBinPath}
      chmod +x ${winboatBinPath}
      ln -s ${desktopItem}/share $out
    '';
}
