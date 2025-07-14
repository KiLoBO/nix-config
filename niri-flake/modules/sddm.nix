{ pkgs, ... }:

let
  custom_sddm_astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
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
      };
    };
  };
}
