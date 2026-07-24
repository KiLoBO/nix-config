{ pkgs, helix-notes }:
helix-notes.packages.${pkgs.system}.default.overrideAttrs (old: {
  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
  postFixup = ''
    ${old.postFixup or ""}
    wrapProgram $out/bin/helixnotes \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [ pkgs.libayatana-appindicator ]}
  '';
})
