{ ... }:
{
  flake.modules.nixos.git =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        package = pkgs.git.override { withLibsecret = true; };
        settings = {
          credential.helper = "libsecret";
        };
      };
    };
}
