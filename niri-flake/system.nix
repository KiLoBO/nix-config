{ pkgs, ... }:
{
  # Niri specific services/settings (sys level)
  programs.niri.enable = true;
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.hyprlock = { };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-session --time --cmd niri-session --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
        user = "greeter";
      };
    };
  };

  users.users.david = {
    packages = with pkgs; [
      swaybg
      swaynotificationcenter
      wlogout
      hyprlock
      hypridle
      pavucontrol
      fuzzel
    ];

    services = {
      services.hypridle.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueman
    libnotify
    xdg-desktop-portal-gnome
  ];
}
