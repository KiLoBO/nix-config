{ config, ... }:
{
  flake.modules.nixos.universal.imports = with config.flake.modules.nixos; [
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

  flake.modules.homeManager.universal.imports = with config.flake.modules.homeManager; [
    users
    pkgs-main
    catppuccin
    editors
  ];
}
