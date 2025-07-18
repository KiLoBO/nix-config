{
  config,
  pkgs,
  ...
}:
{
  # Set flavor and enable globally
  catppuccin.enable = true;
  catppuccin = {
    accent = "lavender";
    flavor = "mocha";
  };

  gtk = {
    enable = true;
    font.name = "TeX Gyre Adventor 10";
    # theme = {
    #   name = "Juno-Mirage";
    #   package = pkgs.juno-theme;
    # };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    catppuccin = {
      enable = true;

      flavor = "mocha";
      accent = "lavender";

      icon.enable = true;
      icon.accent = "lavender";
      icon.flavor = "mocha";
    };
  };
}
