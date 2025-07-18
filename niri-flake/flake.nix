{
  description = "Niri Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    {
      # System-level config
      nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Base sys config (not env specific)
          ../configuration.nix
          # ENV specific sys config
          ./system.nix
          # Extra Modules
          ./modules/sddm.nix

          catppuccin.nixosModules.catppuccin
          ../shared/themes/catppuccin

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.david = {
              imports = [
                ../shared/home-base.nix
                ./home-niri.nix

                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };
}
