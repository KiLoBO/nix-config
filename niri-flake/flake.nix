{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      # System-level config
      nixosConfiguration.nixpad = nixpkgs.lib.nixosSystem {
        modules = [
          ./system.nix # Niri specific system additions
        ];
      };

      # user-level config (home-manager)
      homeConfigurations.david = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home.nix
        ];
      };
    };
}
