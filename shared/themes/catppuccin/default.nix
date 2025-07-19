{
  config,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    capitaine-cursors-themed
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Capitaine Cursors (Palenight)";
    # GTK_THEME = "Tokyonight-Dark";
    GTK_THEME = "Colloid-Pink-Dark-Catppuccin";
  };

  # Set flavor and enable globally
  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "mocha";
    gtk = {
      icon.enable = true;
      icon.accent = "lavender";
      icon.flavor = "mocha";
    };
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
}
