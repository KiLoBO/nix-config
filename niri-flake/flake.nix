{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { nixpkgs, ... }:
    {
      # System-level config
      nixosConfiguration.nixpad = nixpkgs.lib.nixosSystem {
        modules = [
          ./system.nix # Niri specific system additions
        ];
      };
    };
}
