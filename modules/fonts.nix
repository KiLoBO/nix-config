{ ... }:
{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.caskaydia-cove
        nerd-fonts.caskaydia-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.fantasque-sans-mono
        material-symbols
      ];
    };
}
