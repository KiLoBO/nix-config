{
  description = "Shared Sys and Home configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      dms,
      dgop,
    }@inputs:
    {
      nixosModules = {
        base =
          { config, pkgs, ... }:
          {
            imports = [ ./base/system.nix ];
          };

        sddm = ./modules/sddm;
        dod-certs = ./modules/dod/dod-certs.nix;
        cac-read = ./modules/dod/cac-read.nix;
        nix-ld = ./modules/nix-ld;
        catppuccin = ./themes/catppuccin/stylix-sys.nix;

        all-features =
          { ... }:
          {
            imports = [
              ./base/system.nix
              ./modules/sddm
              ./modules/dod/dod-certs.nix
              ./modules/dod/cac-read.nix
              ./modules/nix-ld
            ];
          };
      };

      homeModules = {
        base = ./base/home.nix;
        catppuccin = ./themes/catppuccin;

        dms-base =
          {
            config,
            lib,
            pkgs,
            ...
          }:
          {
            imports = [ inputs.dms.homeModules.dank-material-shell ];
            programs.dank-material-shell = {
              enable = lib.mkDefault true;
              enableSystemMonitoring = lib.mkDefault true;
              dgop.package = inputs.dgop.packages.${pkgs.system}.default;
            };
          };

        default =
          { ... }:
          {
            imports = [
              ./base/home.nix
            ];
          };
      };

      inherit (inputs) dms dgop;
    };
}
