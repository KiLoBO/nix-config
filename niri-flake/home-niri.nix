{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    swaybg
    swaynotificationcenter
    wlogout
    hyprlock
    pavucontrol
    waybar

    # gnome portal required
    nautilus
    nautilus-open-any-terminal
  ];

  xdg.portal.config = {
    niri = {
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
}
