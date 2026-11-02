{ ... }:
{
  flake.modules.nixos.settings =
    { pkgs, ... }:
    {
      imports = [
        ../_hardware-configuration.nix
      ];

      # no touchy
      system.stateVersion = "25.05";

      # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 5;

      # Hostname
      networking.hostName = "nixpad";

      # Nnetworking
      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = false;

      # TimeZone
      time.timeZone = "America/Los_Angeles";

      # Locale
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      # Enable the X11 windowing system
      # Can disable if only using the wayland session
      services.xserver.enable = true;
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Printing (CUPS)
      services.printing.enable = true;

      # Audio
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.permittedInsecurePackages = [
        "electron-40.10.5"
      ];

      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
          vpl-gpu-rt
        ];
      };

      programs.steam.enable = true;

      services.gvfs.enable = true;
      programs.git.enable = true;

      programs.appimage.enable = true;
      programs.appimage.binfmt = true;

      security.pam.services.gnome-keyring.enable = true;

      services.upower.enable = true;
      services.power-profiles-daemon.enable = true;

      services.flatpak.enable = true;
      systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Enable Wayland support for Ozone
        XCURSOR_THEME = "Capitaine Cursors (Palenight)";
        XCURSOR_SIZE = "24";
        LIBVA_DRIVER_NAME = "iHD";
      };

      programs.zsh.enable = true;
    };
}
