{
  pkgs,
  ...
}:

{
  # Enable smart card support
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
        # Add reader lib to FF
        "OpenSC" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
      };
    };
  };
}
