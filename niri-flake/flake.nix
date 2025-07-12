{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }:
    {
      # System-level config
      nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system.nix
          ../configuration.nix
        ];
      };
    };
}
