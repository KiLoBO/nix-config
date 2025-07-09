{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { nixpkgs, ... }:
    {
      # System-level config
      nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system.nix
          /etc/nixos/configuration.nix
        ];
      };
    };
}
