{ inputs, ... }:
{
  flake.modules.nixos.pkgs-extra =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        # inputs.helix-notes.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
