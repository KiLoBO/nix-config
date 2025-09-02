{
  description = "Niri Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, niri, quickshell, nixpkgs-unstable, ... }@inputs:
  {
    nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { 
        inherit inputs; 
        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true; # if needed
        };
      };
      modules = [
        { nixpkgs.overlays = [ 
            niri.overlays.niri 
        ];}
        { environment.systemPackages = [ quickshell.packages.x86_64-linux.default ]; }
        # Base sys config (not env specific)
        ../configuration.nix
        # ENV specific sys config
        ./system.nix
        # Extra Modules
        ./modules/sddm.nix
        # Nix-ld
        ../shared/nix-ld.nix
        niri.nixosModules.niri
        catppuccin.nixosModules.catppuccin

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = { inherit inputs; };

          home-manager.users.david = {
            imports = [
              ../shared/home-base.nix
              ./home-niri.nix
              catppuccin.homeModules.catppuccin
              ../shared/themes/catppuccin
            ];
          };
        }
      ];
    };
  };
}
