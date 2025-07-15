{ pkgs, ... }:

let
  custom_sddm_astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
    themeConfig = {
      Background = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme/Backgrounds/jake_the_dog.mp4";
    };
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    wayland.enable = true;
    extraPackages = with pkgs; [
      custom_sddm_astronaut
      #sddm-astronaut
      kdePackages.qtbase
      kdePackages.qtwayland
      kdePackages.qtmultimedia
    ];
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
        ThemeDir = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme/Themes";
      };
    };
  };
}
