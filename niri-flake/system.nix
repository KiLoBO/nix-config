{ config, lib, pkgs, inputs, ... }:
{
  # Niri specific services/settings (sys level)
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-stable;
  niri-flake.cache.enable = true;
  
  services.gnome.gnome-keyring.enable = true; # secret service
  programs.seahorse.enable = true;
  services.hypridle.enable = true;
  security.pam.services.hyprlock = { };
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueman
    libnotify
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite
    libsecret
  ];

  # Theming
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "lavender";
  catppuccin.sddm.enable = false;

}
