{ pkgs, ... }:
{
  # Niri specific services/settings (sys level)
  programs.niri.enable = true;
  services.gnome.gnome-keyring.enable = true; # secret service
  programs.seahorse.enable = true;
  services.hypridle.enable = true;
  security.pam.services.hyprlock = { };

  # users.users.david = {
  #   packages = with pkgs; [
  #     Should stay un-used. Use HM for user pkgs.
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueman
    libnotify
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xwayland-satellite
    libsecret
  ];
}
