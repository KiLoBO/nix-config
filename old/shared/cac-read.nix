{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable smart card support
  services.pcscd.enable = true;

  # Install CAC middleware and tools
  environment.systemPackages = with pkgs; [
    # Core CAC tools
    opensc # Smart card library and tools
    pcsc-tools # Tools for testing smart card readers
    ccid # USB smart card reader driver

  ];

  # Enable CAC support in Firefox
  programs.firefox = {
    enable = true;
    policies = {
      Certificates = {
        ImportEnterpriseRoots = true;
      };
      SecurityDevices = {
        # Add OpenSC PKCS#11 module for CAC access
        "OpenSC" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
      };
    };
  };
}
