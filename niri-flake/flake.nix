{
  description = "Niri Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      # System-level config
      nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system.nix
          ../configuration.nix
          ./modules/sddm.nix
        ];
      };
    };
}
