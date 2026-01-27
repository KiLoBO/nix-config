{
  description = "Extra packages and modules collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # All the inputs that our package modules need
    winboat = {
      url = "github:TibixDev/winboat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Add more package inputs here as you add packages
    # example-package = {
    #   url = "github:user/package";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, winboat, ... }@inputs: 
  let
    # Get the list of modules from winboat
    winboatModules = (import ./winboat).outputs.nixosModules { inherit inputs; };
    # example-packageModules = (import ./example-package).outputs.nixosModules { inherit inputs; };
  in
  {
    nixosModules = {
      # Individual modules - flatten the lists
      winboat = { ... }: {
        imports = winboatModules;
      };
      
      # Add more packages here
      # example-package = { ... }: {
      #   imports = example-packageModules;
      # };
      
      # The "all" module that imports everything
      all = { ... }: {
        imports = [
          self.nixosModules.winboat
          # self.nixosModules.example-package
        ];
      };
    };
  };
}
