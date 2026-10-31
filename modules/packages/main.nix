{ ... }:
{
  flake.modules.nixos.pkgs-main =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vscode
        zsh
        vim
        neovim
        maple-mono.Normal-NF
        killall
        nix-index
        docker-compose
        winboat
        rustup

        # AstroNVIM
        gccgo15
        nodejs
        git
        python3
      ];
    };

  flake.modules.homeManager.pkgs-main =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fastfetch
        nil
        nixfmt
        starship
        btop
        kitty
        nitch
        zellij
        obsidian
        pipes-rs
        wl-clipboard
        brightnessctl
        yazi
        thunar
        thunar-archive-plugin
        kdePackages.ark
        xdg-utils
        imagemagick
        hyprpicker
        manix
        tree
        gtk-engine-murrine
        glib
        unzip
        claude-code
        jellyfin-media-player
        discord
        rustscan
        vivid
        nmgui
        calibre
        zed-editor
        orca-slicer
        freerdp
        libreoffice-fresh
        hunspell
        hunspellDicts.en_US-large
        protonup-qt
        go
        filezilla
        jq

        # AstroNVIM Required
        ripgrep
        lazygit

        # LSP
        lua-language-server
        yaml-language-server
        ruff
        selene
        stylua
        dotenv-linter
        nixd

        # python
        uv
        python313Packages.textual
        python313Packages.textual-dev
        python313Packages.rich
      ];

      programs.kitty = {
        enable = true;
        font = {
          name = "Maple Mono NF";
          size = 12;
        };
        settings = {
          bold_font = "auto";
          italic_font = "family='Maple Mono NF' features=+calt";
          bold_italic_font = "auto";
          enable_audio_bell = "no";
          window_padding_width = 15;
          cursor_trail = 1;
          confirm_os_window_close = 0;
        };
        themeFile = "Catppuccin-Macchiato";
      };

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

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.command-not-found.enable = true;
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
    };
}
