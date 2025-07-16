# To add quickshell (flake)

In flake.nix:
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      quickshell,
      ...
    }:
    {
      # System-level config
      nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system.nix
          ../configuration.nix
          ./modules/sddm.nix
          { environment.systemPackages = [ quickshell.packages.x86_64-linux.default ]; }
        ];
      };
    };
}
```

## System dependencies need to be installed too:
```nix
environment.systemPackages = with pkgs; {
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtmultimedia
    kdePackages.qt5compat
};
```