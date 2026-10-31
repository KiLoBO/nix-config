{ ... }:
{
  flake.modules.nixos.catppuccin =
    { pkgs, ... }:
    {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        autoEnable = false;
      };
    };

  flake.modules.homeManager.catppuccin =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        capitaine-cursors-themed
      ];

      home.sessionVariables = {
        XCURSOR_THEME = "Capitaine Cursors (Palenight)";
        GTK_THEME = "Colloid-Pink-Dark-Catppuccin";
      };

      gtk = {
        enable = true;
        font.name = "TeX Gyre Adventor 10";
        # theme = {
        #   name = "Tokyonight-Dark";
        #   package = pkgs.tokyonight-gtk-theme;
        # };
        theme = {
          name = "Colloid-Pink-Dark-Catppuccin";
          package = pkgs.colloid-gtk-theme.override {
            colorVariants = [ "dark" ];
            themeVariants = [ "pink" ];
            tweaks = [
              "catppuccin"
              "rimless"
            ];
          };
        };

        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };

        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
      };
    };
}
