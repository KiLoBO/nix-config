{ ... }:
{
  flake.modules.nixos.users =
    { pkgs, ... }:
    {
      users.users.david = {
        isNormalUser = true;
        description = "david";
        shell = pkgs.zsh;
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "input"
        ];
      };
    };

  flake.modules.homeManager.users =
    { pkgs, ... }:
    {
      # no touchy
      home.stateVersion = "25.05";

      home.username = "david";
      home.homeDirectory = "/home/david";

      home.sessionVariables = {
        EDITOR = "nvim";
        PATH = "$PATH:/home/david/.local/bin:/home/david/.cargo/bin:/home/david/.local/share/nvim/mason/bin";
        TERMINAL = "kitty";
      };
    };
}
