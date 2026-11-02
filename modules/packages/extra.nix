{ inputs, ... }:
{
  flake.modules.nixos.pkgs-extra =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.helixnotes
        inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
