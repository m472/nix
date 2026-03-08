{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = {
    home = {
      packages =
        with pkgs;
        [
          brightnessctl
          dunst
          fuzzel
          grim
          nerd-fonts.fira-mono
          niri
          # noctalia
          slurp
          swaybg
          udiskie
          wev
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
          xwayland-satellite
        ]
        ++ (if config.device.touchpad.available then [ touchpadctl ] else [ ]);
    };

    programs = {

      # noctalia-shell = {
      #   bar = {
      #     density = "compact";
      #     position = "right";
      #     showCapsule = false;
      #     widgets = {
      #       left = [
      #         {
      #           id = "ControlCenter";
      #           useDistroLogo = true;
      #         }
      #         {
      #           id = "Network";
      #         }
      #         {
      #           id = "Bluetooth";
      #         }
      #       ];
      #       center = [
      #         {
      #           hideUnoccupied = false;
      #           id = "Workspace";
      #           labelMode = "none";
      #         }
      #       ];
      #       right = [
      #         {
      #           alwaysShowPercentage = true;
      #           id = "Battery";
      #           warningThreshold = 10;
      #         }
      #         {
      #           formatHorizontal = "HH:mm";
      #           formatVertical = "HH:mm";
      #           id = "Clock";
      #           useMonospacedFont = true;
      #           usePrimaryColor = true;
      #         }
      #       ];
      #     };
      #   };
      #   colorSchemes.predefinedScheme = "Monochrome";
      #   location = {
      #     monthBeforeDay = false;
      #     name = "Zurich, Switzerland";
      #   };
      # };

      hyprlock = {
        enable = true;
        settings = {
          general = {
            grace = 10;
            hide_cursor = true;
          };

          background = [
            {
              monitor = "";
              path = "${config.xdg.configHome}/hypr/background.png";
            }
          ];

          input-field = [
            {
              size = "600, 60";
              outline-thickness = 3;
              dots_size = 0.33;
              dots_spacing = 0.15;
              dots_center = true;
              dots_rounding = -1;
              outer_color = "rgb(0, 179, 179)";
              inner_color = "rgb(200, 200, 200)";
              font_color = "rgb(10, 10, 10)";
              font_size = 30;
              fade_on_empty = true;
              fade_timeout = 1000;
              placeholder_text = "Password";
              rounding = 20;

              position = "0, 100";
              halign = "center";
              valign = "bottom";
            }
          ];

          label = [
            {
              monitor = "";
              text = "$TIME";
              text_align = "center";
              font_size = 100;
              position = "0, 100";
              halign = "center";
              valign = "center";
            }

            {
              monitor = "";
              text =
                if config.device.battery.available then
                  ''
                    cmd[update: 10000] echo -e "󰂎  $(upower -i /org/freedesktop/UPower/devices/battery_${config.device.battery.id} | rg 'percentage:' | choose 1 | sed 's/%//' | cut --delimiter '.' --fields 1)%\n$(cat /sys/class/power_supply/${config.device.battery.id}/status)"
                  ''
                else
                  "";
              text_align = "right";
              font_size = 25;
              position = "-50, -50";
              halign = "right";
              valign = "top";
            }

            {
              monitor = "";
              text = "$DESC";
              text_align = "center";
              font_size = 25;
              position = "50, -50";
              halign = "left";
              valign = "top";
            }
          ];
        };
      };
    };

    services = {
      dunst = {
        enable = true;
        settings = {
          global = {
            corner_radius = 6;
          };

          frame = {
            width = "1.5";
            frame = "#1be7cc";
          };

          urgency_low = {
            background = "#000000";
            foreground = "#ffffff";
            frame_color = "#00b3b3";
          };

          urgency_normal = {
            background = "#000000";
            foreground = "#ffffff";
            frame_color = "#00b3b3";
          };

          urgency_critical = {
            background = "#ff0000";
            foreground = "#ffffff";
            frame_color = "#00b3b3";
          };
        };
      };
    };
  };
}
