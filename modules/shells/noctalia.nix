{ inputs, ... }:
{
  flake.modules.homeManager.noctalia-base =
    { lib, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = lib.mkDefault true;

        settings = {
          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Catppuccin";
          };

          wallpaper = {
            enabled = true;
            default.path = "/home/david/Pictures/wallpaper/spookyspillUpscaled.jpeg";
          };
        };
      };
    };
}
