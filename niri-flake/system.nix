{ pkgs, ... }:
{
  # Niri specific services/settings (sys level)
  programs.niri.enable = true;
  services.gnome.gnome-keyring.enable = true; # secret service
  services.hypridle.enable = true;
  security.pam.services.hyprlock = { };

  users.users.david = {
    packages = with pkgs; [
      swaybg
      swaynotificationcenter
      wlogout
      hyprlock
      pavucontrol
      fuzzel
      waybar
    ];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueman
    libnotify
    xdg-desktop-portal-gnome
    xwayland-satellite

    # QT
    #libsForQt5.qt5.qtsvg
    #libsForQt5.qt5.qtimageformats
    #libsForQt5.qt5.qtmultimedia
    #kdePackages.qt5compat
  ];
}
