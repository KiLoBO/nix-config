{
  config,
  pkgs,
  lib,
  ...
}:

let
  dodCertsPackage = pkgs.stdenv.mkDerivation {
    name = "dod-certificates";
    src = pkgs.fetchurl {
      url = "https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_DoD.zip";
      sha256 = "sha256-04apnzxyj12j04qvh3sjq71zq1vc417nlb6xrqimipsjwzdmln9j";
    };
    nativeBuildInputs = [
      pkgs.unzip
      pkgs.openssl
    ];

    unpackPhase = ''
      unzip $src -d extracted
    '';
    installPhase = ''
      mkdir -p $out/certs
      # Convert PKCS7 to PEM
      for f in extracted/*.p7b; do
        if [ -f "$f" ]; then
            name=$(basename "$f" .p7b)
            openssl pkcs7 -in "$f" -print_certs -out "$out/certs/$name.pem" 2>/dev/null || true
        fi
      done
    '';
  };
in
{
  security.pki.certificateFiles = lib.mapAttrsToList (name: _: "${dodCertsPackage}/certs/${name}") (
    builtins.readDir "${dodCertsPackage}/certs"
  );

  programs.firefox = {
    enable = true;
    policies = {
      Certificates = {
        ImportEnterpriseRoots = true;
      };
    };
  };
}
