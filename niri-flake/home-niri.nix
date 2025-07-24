{ config, pkgs, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    swaybg
    swaynotificationcenter
    wlogout
    hyprlock
    pavucontrol
    waybar

    # gnome portal required
    nautilus
    nautilus-open-any-terminal
  ];

  xdg.portal.config = {
    niri = {
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # NIRI CONFIG
  programs.niri.settings = {
    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    
    environment = {
      DISPLAY = ":0";
    };
  
    outputs."eDP-1" = {
      enable = true;
      mode = {
        width = 1920;
        height = 1080;
        refresh = 60.0;
      };
      scale = 1.0;
    };

    spawn-at-startup = [
      # { command = ["waybar"]; }
      # { command = ["nm-applet"]; }
      { command = ["swaybg" "-i" "/home/david/gitProjects/nix-config/shared/wallpaper/spookyspillUpscaled.jpeg"]; }
      # { command = ["swaync"]; }
      { command = ["hypridle"]; }
      { command = ["wl-paste" "--watch" "cliphist" "store"]; }
      { command = ["xwayland-satellite"]; }
      # { command = ["sh" "-c" "cd ~/gitProjects/clones/astal-bar && nix develop --command nix run .#default"]; }
      { command = ["qs" "-c" "DankMaterialShell"]; }
    ];

    input = {
      keyboard = {
        numlock = true;
      };

      touchpad = {
        enable = true;
        tap = true;
        dwt = true;
        natural-scroll = false;
        scroll-method = "two-finger";
        disabled-on-external-mouse = true;
      };
    };

    cursor = {
      size = 24;
      theme = "Capitaine Cursors (Palenight)";
    };

    layout = {
      gaps = 16;
      center-focused-column = "never";
      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];
    
      default-column-width = { proportion = 1.0 / 2.0; };      
    
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#7fc8ff";
        inactive.color = "#505050";
      };
      
      border = {
        enable = false;
        width = "4";
        active.color = "#ffc87f";
        inactive.color = "#505050";
        urgent.color = "#9b0000";
      };

      shadow = {
        enable = false;
        softness = 30;
        spread = 5;
        color = "#0007";
        inactive-color = "#0007";
        offset.x = 0; 
        offset.y = 5;
      };

      struts = {
        # bottom = 64; 
        # left = 64;
        # right = 64;
        # top = 64;
      };
    };

    animations = {
      enable = true;
    };
    
    # window-rules = [
    #   {
    #     matches = [
    #       {
    #         app-id = ''r#"firefox$"#'';
    #         title = ''^Picture-in-Picture$'';
    #       }
    #     ];
    #     open-floating = true;
    #   }
    # ];

    binds = {
      # General system
      "Mod+V".action.spawn = "~/gitProjects/nix-config/helpers/cliphist-fuzzel-img.sh";
      "Mod+Shift+P".action.spawn = ["hyprpicker" "-an"];
      "Mod+Return".action.spawn = "kitty";
      "Mod+D".action.spawn = "fuzzel";
      "Super+Alt+L".action.spawn = "hyprlock";
      "Mod+E".action.spawn = "thunar";
      "Print".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};

      "Mod+Shift+E".action.quit = {};
      "Ctrl+Alt+Delete".action.quit = {};
      
      "Mod+Escape" = {
        action.toggle-keyboard-shortcuts-inhibit = {};
        allow-inhibiting = false;
      };

      # Media Keys
      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
      "XF86AudioRaiseVolume".allow-when-locked = true;
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
      "XF86AudioLowerVolume".allow-when-locked = true;
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      "XF86AudioMute".allow-when-locked = true;
      "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
      "XF86AudioMicMute".allow-when-locked = true;
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "+5%"];
      "XF86MonBrightnessUp".allow-when-locked = true;
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
      "XF86MonBrightnessDown".allow-when-locked = true;

      # General Binds
      "Mod+O".action.toggle-overview = {};
      "Mod+Q".action.close-window = {};
      
      # Workspaces/Columns/etc...
      "Mod+Left".action.focus-column-left = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+H".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+L".action.focus-column-right = {};

      "Mod+Ctrl+Left".action.move-column-left = {};
      "Mod+Ctrl+Down".action.move-window-down = {};
      "Mod+Ctrl+Up".action.move-window-up = {};
      "Mod+Ctrl+Right".action.move-column-right = {};
      "Mod+Ctrl+H".action.move-column-left = {};
      "Mod+Ctrl+J".action.move-window-down = {};
      "Mod+Ctrl+K".action.move-window-up = {};
      "Mod+Ctrl+L".action.move-column-right = {};

      "Mod+Home".action.focus-column-first = {};
      "Mod+End".action.focus-column-last = {};
      "Mod+Ctrl+Home".action.move-column-to-first = {};
      "Mod+Ctrl+End".action.move-column-to-last = {};
      
      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};

      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = {};
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = {};
        cooldown-ms = 150;
      };
      "Mod+Shift+WheelScrollDown".action.focus-column-right = {};
      "Mod+Shift+WheelScrollUp".action.focus-column-left = {};

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      # Switches focus between the current and previous workspace
      "Mod+Tab".action.focus-workspace-previous = {};

      # The following binds move the focused window in and out of a column.
      # If the window is alone, they will consume it into the nearby column to the side.
      # If the window is already in a column, they will expell it out.
      "Mod+BracketLeft".action.consume-or-expel-window-left = {};
      "Mod+BracketRight".action.consume-or-expel-window-right = {};

      # Consume one window from the right to the bottom of the focused column.
      "Mod+Comma".action.consume-window-into-column = {};
      # Expel the bottom window from the focused column to the right.
      "Mod+Period".action.expel-window-from-column = {};

      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Shift+R".action.switch-preset-window-height = {};
      "Mod+Ctrl+R".action.reset-window-height = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};

      # Expand the focused column to space not taken up by other fully visible columns.
      # Makes the column "full the rest of the space".
      "Mod+Ctrl+F".action.expand-column-to-available-width = {};

      "Mod+C".action.center-column = {};

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Mod+W".action.toggle-window-floating = {};
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};
    };
  };
}
