{
  description = "Imports extra packages";
  outputs =
    { ... }:
    {
      nixosModules = { 
        # Winboat
        winboat = import ./winboat;
      };
    };
}
