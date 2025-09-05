{ ... }:

{
  outputs.nixosModules =
    { ... }:
    [
      (
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          nixpkgs.overlays = [
            (final: super: {
              winboat = final.callPackage ./package.nix { };
            })
          ];

          boot.kernelModules = [
            "ip_tables"
            "iptable_nat"
          ];

          environment.systemPackages = with pkgs; [
            freerdp
            winboat
          ];

          virtualisation.docker.enable = true;

          icedos.applications.toolset.commands = [
            (
              let
                command = "clear-winboat";
                docker = "${pkgs.docker}/bin/docker";
              in
              {
                bin = "${pkgs.writeShellScript command ''
                  ${docker} stop WinBoat
                  ${docker} rm WinBoat
                  ${docker} volume rm winboat_data
                  rm -rf ~/.winboat
                ''} 2> /dev/null";
                command = command;
                help = "purge all winboat files for a clean installation";
              }
            )
          ]; 
        }
      )
    ];

}
