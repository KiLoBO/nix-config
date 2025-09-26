{
  description = "Extra packages and modules collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules = {
      # Export all package modules - each handles its own inputs
      winboat = import ./winboat;
      
      # Add other packages here
      # example-package = import ./example-package;
      
      # Convenience module that imports all packages
      all = { ... }: {
        imports = [
          self.nixosModules.winboat
          # self.nixosModules.example-package
        ];
      };
    };
  };
}
