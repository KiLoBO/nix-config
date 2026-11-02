{ ... }:
{
  flake.modules.nixos.cac-read =
    { pkgs, ... }:
    {
      services.pcscd.enable = true;

      environment.systemPackages = with pkgs; [
        opensc
        pcsc-tools
        ccid
      ];

      programs.firefox = {
        enable = true;
        policies = {
          Certificates = {
            ImportEnterpriseRoots = true;
          };
          SecurityDevices = {
            "OpenSC" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
          };
        };
      };
    };
}
