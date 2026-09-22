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
          hyprcursor
          hyprland
          hyprpaper
          hyprpolkitagent
          libnotify
          nerd-fonts.fira-mono
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
      shikane.enable = true;

      udiskie = {
        enable = true;
        notify = true;
      };
    };
  };
}
