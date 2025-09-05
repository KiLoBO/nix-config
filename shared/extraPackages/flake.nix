{
  description = "Imports extra packages";
  outputs =
    { ... }:
    {
      modules = [
        # Winboat
        ./winboat
      ];
    };
}
