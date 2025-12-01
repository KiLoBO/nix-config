{ config, lib, pkgs, inputs, pkgs-unstable, ... }:
{
  # Niri specific services/settings (sys level)
  nixpkgs.overlays = [ 
    inputs.niri.overlays.niri
  ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
  niri-flake.cache.enable = true;
  
  services.gnome.gnome-keyring.enable = true; # secret service
  programs.seahorse.enable = true;
  services.hypridle.enable = true;
  security.pam.services.hyprlock = { };
  programs.dconf.enable = true;
  qt.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueman
    libnotify
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite
    libsecret
    niri-stable
    manix

    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum
    matugen
  ] ++ (with pkgs-unstable; [
    # nmgui
    rio
  ]);
}
