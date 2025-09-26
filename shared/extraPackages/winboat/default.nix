{ ... }:
{
  inputs.winboat = {
    url = "github:TibixDev/winboat";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs.nixosModules = 
    { inputs, ... }:
    [
      inputs.winboat.nixosModules.x86_64-linux.default

      (
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          services.winboat.enable = true;

          users.users = lib.mapAttrs (user: _: {
            extraGroups = [ "docker" ];
          });
        }
      )
    ];

  meta.name = "winboat";
}
