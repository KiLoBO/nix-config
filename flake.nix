{
  description = "Shared Sys and Home configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-monitor = {
      url = "github:antonjah/nix-monitor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-notes = {
      url = "git+https://codeberg.org/ArkHost/HelixNotes";
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
      nix-monitor,
      helix-notes,
    }@inputs:
    {
      nixosModules = {
        base =
          { config, pkgs, ... }:
          {
            imports = [ ./base/system.nix ];
            environment.systemPackages = [
              inputs.helix-notes.packages.${pkgs.system}.default
            ];
          };

        sddm = ./modules/sddm;
        dod-certs = ./modules/dod/dod-certs.nix;
        cac-read = ./modules/dod/cac-read.nix;
        nix-ld = ./modules/nix-ld;
        catppuccin = ./themes/catppuccin/stylix-sys.nix;

        all-features =
          { pkgs, ... }:
          {
            imports = [
              ./base/system.nix
              ./modules/sddm
              ./modules/dod/dod-certs.nix
              ./modules/dod/cac-read.nix
              ./modules/nix-ld
            ];
            environment.systemPackages = [
              inputs.helix-notes.packages.${pkgs.system}.default
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
            imports = [
              inputs.dms.homeModules.dank-material-shell
              inputs.nix-monitor.homeManagerModules.default
            ];
            programs.dank-material-shell = {
              enable = lib.mkDefault true;
              enableSystemMonitoring = lib.mkDefault true;
              dgop.package = inputs.dgop.packages.${pkgs.system}.default;
            };
            programs.nix-monitor = {
              enable = true;
              nixpkgsChannel = "nixos-26.05";
              rebuildCommand = [
                "bash"
                "-c"
                "nh os switch -a $NH_FLAKE"
              ];
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

      inherit (inputs) dms dgop nix-monitor;
    };
}
