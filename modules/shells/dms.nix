{ inputs, ... }:
{
  flake.modules.homeManager.dms-base =
    { lib, ... }:
    {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.nix-monitor.homeManagerModules.default
      ];

      programs.dank-material-shell = {
        enable = lib.mkDefault true;
        enableSystemMonitoring = lib.mkDefault true;
      };

      programs.nix-monitor = {
        enable = true;
        nixpkgsChannel = "nixos-26.05";
        rebuildCommand = [
          "bash"
          "-c"
          "nh os switch -a $NH_FLAKE"
        ];
      };
    };
}
