{ pkgs, ... }:

# Set the theme in embeddedTheme according to name in sddm-astronaut repo.
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    wayland.enable = true;
    extraPackages = [
      sddm-astronaut
      pkgs.kdePackages.qtbase
      pkgs.kdePackages.qtwayland
      pkgs.kdePackages.qtmultimedia
    ];
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };
  environment.systemPackages = [ sddm-astronaut ];
}
