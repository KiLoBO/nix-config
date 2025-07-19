{ config, pkgs, ... }:

{
  home.username = "david";
  home.homeDirectory = "/home/david";
  # nixpkgs.config.allowUnfree = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # ----------------------------------------------------------------------------

  home.packages = [
    pkgs.fastfetch
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.starship
    pkgs.btop
    pkgs.kitty
    pkgs.nitch
    pkgs.nh
    pkgs.zellij
    pkgs.obsidian
    pkgs.pipes-rs
    pkgs.wl-clipboard
    pkgs.brightnessctl
    pkgs.yazi
    pkgs.xfce.thunar
    pkgs.xdg-utils
    pkgs.imagemagick
    pkgs.hyprpicker
    pkgs.webcord
    pkgs.manix
    pkgs.tree
    pkgs.gtk-engine-murrine

    # AstroNVIM Required
    pkgs.ripgrep
    pkgs.lazygit

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$PATH:/home/david/.cargo/bin:/home/david/.local/share/nvim/mason/bin";
    TERMINAL = "kitty";
  };

  # ----------------------------------------------------------------------------

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    colors.background = "24273add";
    colors.text = "cad3f5ff";
    colors.prompt = "b8c0e0ff";
    colors.placeholder = "8087a2ff";
    colors.input = "cad3f5ff";
    colors.match = "c6a0f6ff";
    colors.selection = "5b6078ff";
    colors.selection-text = "cad3f5ff";
    colors.selection-match = "c6a0f6ff";
    colors.counter = "8087a2ff";
    colors.border = "c6a0f6ff";
  };

  services.cliphist.enable = true;

  # gtk = {
  #   enable = true;
  #   font.name = "TeX Gyre Adventor 10";
  #   theme = {
  #     name = "Juno-Mirage";
  #     package = pkgs.juno-theme;
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #
  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };
  #
  #   gtk4.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };
  # };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update-nix = "nh os switch -a -f '<nixpkgs/nixos>'";
      clear = "clear; nitch";
      ssh = "kitten ssh";
      fmanix = ''manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" | xargs manix'';
    };

    initContent = ''
      nitch
      eval "$(starship init zsh)"
    '';
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      ruff
      selene
      stylua
    ];
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        dracula-theme.theme-dracula
        catppuccin.catppuccin-vsc-icons
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "save-as-root";
          publisher = "yy0931";
          version = "1.11.0";
          sha256 = "NziiIY/qTFvJMwPoIIu2xLMPL9mn3gB3VSaItHIvfCI=";
        }
        {
          name = "nix-ide";
          publisher = "jnoortheen";
          version = "0.4.22";
          sha256 = "j3V03Aa1mHO9rny3/hXmDbs3fmruqyzNzwFjiOlnaMU=";
        }
      ];
  };

}
