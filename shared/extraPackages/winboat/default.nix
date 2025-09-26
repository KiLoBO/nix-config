{ config, lib, pkgs, ... }:

let
  winboat = builtins.getFlake "github:TibixDev/winboat";
in
{
  imports = [
    winboat.nixosModules.x86_64-linux.default
  ];

  config = {
    # Enable winboat service
    services.winboat.enable = true;

    # Add all normal users to docker group for winboat
    users.users = lib.mapAttrs (name: user: 
      lib.optionalAttrs user.isNormalUser {
        extraGroups = user.extraGroups or [] ++ [ "docker" ];
      }
    ) config.users.users;

    # Add any winboat-specific system packages if needed
    # environment.systemPackages = with pkgs; [
      # Add packages that winboat might need
    # ];
  };
}
