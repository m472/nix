{

  pkgs,
  lib,
  config,
  ...
}:
let
  backgroundFile = "${config.xdg.configHome}/hypr/background.png";
in
{
  imports = [
    ./noctalia.nix
    # ./waybar-and-stuff.nix
  ];
  options = {
    hyprland.specificMonitorConfigs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = {
    home = {
      packages =
        with pkgs;
        [
          brightnessctl
          dunst
          nerd-fonts.fira-mono
          hyprland
          hyprpaper
          hyprcursor
          hyprpolkitagent
          papirus-icon-theme
          rose-pine-hyprcursor
          wev
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-wlr
        ]
        ++ (if config.device.touchpad.available then [ touchpadctl ] else [ ]);
      file = {
        "${backgroundFile}" = {
          enable = true;
          source = ./files/background.png;
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      extraLuaFiles = lib.mkMerge [
        {
          defs = {
            autoLoad = false;
            content = pkgs.replaceVars ./config/hypr/defs.lua {
              touchpadDevice = if config.device.touchpad.available then config.device.touchpad.id else "nil";
              kbdBacklightDevice =
                if config.device.keyboardBacklight.available then config.device.keyboardBacklight.id else "nil";
            };
          };
          main.content = ./config/hypr/main.lua;
        }
        (lib.mkIf config.device.touchpad.available {
          touchpadctl.content = ./config/hypr/touchpadctl.lua;
        })
        (lib.mkIf config.device.keyboardBacklight.available {
          kbd_backlight.content = ./config/hypr/kbd_backlight.lua;
        })
      ];
    };

    services = {
      # dunst = {
      #   enable = true;
      #   settings = {
      #     global = {
      #       corner_radius = 6;
      #     };

      #     frame = {
      #       width = "1.5";
      #       frame = "#1be7cc";
      #     };

      #     urgency_low = {
      #       background = "#000000";
      #       foreground = "#ffffff";
      #       frame_color = "#00b3b3";
      #     };

      #     urgency_normal = {
      #       background = "#000000";
      #       foreground = "#ffffff";
      #       frame_color = "#00b3b3";
      #     };

      #     urgency_critical = {
      #       background = "#ff0000";
      #       foreground = "#ffffff";
      #       frame_color = "#00b3b3";
      #     };
      #   };
      # };

      shikane = {
        enable = true;
        settings = {
          profile = [
            {
              name = "desktop";
              output = [
                {
                  enable = true;
                  search = [
                    "m=ASUS VS247"
                    "s=D6LMTF079392"
                    "v="
                  ];
                  position = "1920,0";
                  mode = "1920x1080@60Hz";
                }
                {
                  enable = true;
                  search = [
                    "m=ASUS VS247"
                    "s=D6LMTF079389"
                    "v="
                  ];
                  position = "0,0";
                  mode = "1920x1080@60Hz";
                }
              ];
            }
          ];
        };
      };

      udiskie = {
        enable = true;
        notify = true;
      };
    };
  };
}
