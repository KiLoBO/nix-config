{ config, ... }:
{
  flake.nixosModules.universal.imports = with config.flake.modules.nixos; [
    settings
    users
    virtualisation
    vpn
    fonts
    file-manager
    sddm
    nix-ld
    cac-read
    dod-certs
    pkgs-main
    catppuccin
    pkgs-extra
  ];

  flake.homeManagerModules.universal.imports = with config.flake.modules.homeManager; [
    users
    pkgs-main
    catppuccin
    editors
  ];
}
