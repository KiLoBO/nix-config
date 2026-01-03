{
  config,
  pkgs,
  lib,
  ...
}:

let
  dodCertsPackage = pkgs.stdenv.mkDerivation {
    pname = "dod-certificates";
    version = "2026";

    src = pkgs.fetchzip {
      url = "https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_DoD.zip";
      sha256 = "sha256-EZIHVEwK+rWHa1cFSrN3w4OQeWKQxTlqfRSyT804Obc=";
      stripRoot = false;
    };

    nativeBuildInputs = [ pkgs.openssl ];

    dontUnpack = true;

    buildPhase = ''
      echo "Contents of src:"
      ls -la $src

      # Go into the actual directory with the certificates
      cd $src/Certificates_PKCS7_v5_14_DoD

      echo "Files in certificate directory:"
      ls -la

      # Process .der.p7b files
      for f in *.der.p7b; do
        if [ -f "$f" ]; then
          echo "Processing $f..."
          openssl pkcs7 -inform DER -in "$f" -print_certs >> /build/dod-certificates.pem
        fi
      done

      # Also process .pem.p7b if it exists
      for f in *.pem.p7b; do
        if [ -f "$f" ]; then
          echo "Processing $f..."
          openssl pkcs7 -in "$f" -print_certs >> /build/dod-certificates.pem
        fi
      done

      echo "Extraction complete. Lines in output: $(wc -l < /build/dod-certificates.pem)"
    '';

    installPhase = ''
      mkdir -p $out

      if [ -f "/build/dod-certificates.pem" ] && [ -s "/build/dod-certificates.pem" ]; then
        cp /build/dod-certificates.pem $out/dod-certificates.pem
        echo "Successfully created certificate bundle with $(wc -l < $out/dod-certificates.pem) lines"
      else
        echo "ERROR: No certificates extracted!"
        exit 1
      fi
    '';
  };
in
{
  security.pki.certificateFiles = [
    "${dodCertsPackage}/dod-certificates.pem"
  ];

  programs.firefox = {
    enable = true;
    policies = {
      Certificates = {
        ImportEnterpriseRoots = true;
      };
    };
  };
}
