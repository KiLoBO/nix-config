{ ... }:
{
  flake.modules.homeManager.editors =
    { pkgs, ... }:
    {
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

      programs.zed-editor = {
        enable = true;
        extensions = [
          "Nix"
          "Docker Compose"
          "Catppuccin Blur"
          "Catppuccin Icons"
          "Material Icon Theme"
        ];
        userSettings = {
          theme = {
            mode = "dark";
            # dark = "Catppuccin Frappé (Blur) [Heavy]";
            dark = "Catppuccin Frappé";
          };
          buffer_font_family = "Maple Mono NF";
          buffer_font_features = {
            calt = true;
          };
          icon_theme = "Material Icon Theme";
          file_icons = true;
          base_keymap = "VSCode";
          ui_font_size = 16;
          buffer_font_size = 16;
          features = {
            edit_prediction_provider = "none";
          };

          terminal = {
            detect_venv = {
              on = {
                directories = [
                  ".env"
                  "env"
                  ".venv"
                  "venv"
                ];
                activate_script = "default";
              };
            };
          };
          theme_overrides = {
            "Catppuccin Frappé (Blur) [Heavy]" = {
              syntax.boolean.font_style = "italic";
              syntax.emphasis.font_style = "italic";
              syntax.keyword.font_style = "italic";
            };
            "Catppuccin Frappé" = {
              syntax.boolean.font_style = "italic";
              syntax.emphasis.font_style = "italic";
              syntax.keyword.font_style = "italic";
            };
          };

          languages = {
            "Python" = {
              language_servers = [
                "ty"
                "!basedpyright"
                "..."
              ];
            };
            "Nix" = {
              language_servers = [
                "nil"
                "!nixd"
              ];
            };
          };
        };
      };
    };
}
