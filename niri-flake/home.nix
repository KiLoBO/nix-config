{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swaybg
    swaynotificationcenter
    wlogout
    hyprlock
    hypridle
    pavucontrol
    fuzzel
  ];

  # User services
  programs.waybar.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  programs.pywal.enable = false;

}
