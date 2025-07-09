{ pkgs, ... }:
{
  # Niri specific services/settings (sys level)
  programs.niri.enable = true;
  services.gnome.gnome-keyring.enable = true; # secret service
  services.hypridle.enable = true;
  security.pam.services.hyprlock = { };
  programs.waybar.enable = true;

  users.users.david = {
    packages = with pkgs; [
      swaybg
      swaynotificationcenter
      wlogout
      hyprlock
      pavucontrol
      fuzzel
    ];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueman
    libnotify
    xdg-desktop-portal-gnome
  ];
}
