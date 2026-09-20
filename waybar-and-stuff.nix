{
  pkgs,
  config,
  ...
}:
let
  backgroundFile = "${config.xdg.configHome}/hypr/background.png";
  screenshotFilepath = "$(xdg-user-dir PICTURES)/$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')";
  screenshotCommand = ''grim -g "$(slurp)" - | tee ${screenshotFilepath} | wl-copy'';
in
{
  config = {
    home = {
      packages = with pkgs; [
        grim
        rofi-power-menu
        rofi
        rofi-bluetooth
        slurp
        waybar
        hypridle
        hyprlock
      ];

      file = {
        "${config.xdg.configHome}/rofi/config.rasi" = {
          enable = true;
          source = ./config/rofi/config.rasi;
        };
      };
    };

    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "waybar"
          "hypridle"
        ];

        bind = [
          ", Print, exec, ${screenshotCommand}"
          "$mainMod, D, exec, rofi -show drun"
          ''$mainMod, P, exec, rofi -show menu -modi "menu:rofi-power-menu"''
          "$mainMod, B, exec, rofi-bluetooth"
        ];
      };
    };

    programs = {
      waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "bottom";
            position = "top";
            height = 20;

            modules-left = [
              "hyprland/mode"
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-center = [
              "custom/logo"
              "clock"
            ];
            modules-right = [
              "backlight"
              "pulseaudio"
              "mpris"
              "network"
              "custom/screenshot"
            ]
            ++ (if config.device.touchpad.available then [ "custom/touchpad" ] else [ ])
            ++ [
              "idle_inhibitor"
              "battery"
            ];
            "hyprland/workspaces" = {
              disable-scroll = true;
              all-outputs = true;
              format = "{name}: {icon}";
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                "urgent" = "";
                "focused" = "";
                "default" = "";
              };
            };
            cpu = {
              interval = 10;
              format = "{usage}% ";
              max-length = 10;
            };
            "custom/logo" = {
              exec = "uname -r | sed s/.x86_64//g";
              format = "{icon} {text}";
              format-icons = [ "  " ];
              icon-size = 20;
            };
            "hyprland/window" = {
              max-length = 60;
              tooltip = false;
            };
            clock = {
              format = "{:%a %d %b %H:%M:%S}";
              tooltip = true;
              tooltip-format = "{calendar}";
              tooltip-font = "mono";
              interval = 1;
            };
            battery = {
              format = "{capacity}% {icon}";
              format-alt = "{time} {icon}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
              format-charging = "{capacity}% ⚡";
              full-at = config.device.battery.fullAt;
              interval = 30;
              states = {
                warning = 25;
                critical = 10;
              };
              tooltip = false;
            };
            network = {
              format = "{ifname}";
              format-disconnected = "󰖪";
              format-wifi = "";
              format-ethernet = "󰈀";
              tooltip-format = "{ifname}";
              tooltip-format-wifi = "{essid} ({signalStrength}%) ";
              tooltip-format-ethernet = "{ifname} ";
              tooltip-format-disconnected = "Disconnected";
              max-length = 50;
              on-click = "nmcli device wifi list --rescan yes";
            };
            bluetooth = {
              format = "";
              format-connected = " {num_connections} connected";
              tooltip-format = "{controller_alias}	{controller_address}";
              tooltip-format-connected = ''
                {controller_alias}	{controller_address}

                {device_enumerate}'';
              tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
            };
            pulseaudio = {
              format = "{icon}";
              format-muted = "";
              format-icons = {
                phone = [
                  " "
                  " "
                  " "
                ];
                default = [
                  ""
                  ""
                  ""
                ];
              };
              scroll-step = 1;
              on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            };
            backlight = {
              format = "{percent}% {icon}";
              format-icons = [
                ""
                ""
              ];
              on-scroll-down = "brightnessctl set +5%";
              on-scroll-up = "brightnessctl --min-value=1 set 5%-";
            };
            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
            "custom/screenshot" = {
              format = "";
              on-click = screenshotCommand;
              tooltip-format = "Take screenshot";
            };

            "mpris" = {
              format = "{player_icon}";
              format-paused = "{status_icon}";
              player-icons = {
                default = "▶";
                mpv = "🎵";
              };
              status-icons = {
                paused = "⏸";
              };
            };
          }
          // (
            if config.device.touchpad.available then
              {
                "custom/touchpad" = {
                  format = "{}";
                  interval = 10;
                  exec = "touchpadctl barstatus '󰟸 ' '󰤳 '";
                  on-click = "touchpadctl toggle --device ${config.device.touchpad.id}";
                  tooltip-format = "";

                };
              }
            else
              { }
          );
        };
        style = builtins.readFile ./config/waybar/style.css;
      };

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
      hyprpaper = {
        enable = true;
        settings = {
          splash = false;
          preload = [ backgroundFile ];
          wallpaper = [ ",${backgroundFile}" ];
        };
      };

      hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "hyprlock";
          };
          listener = [
            {
              timeout = 120; # 2 min
              on-timeout = "brightnessctl --save set 5%";
              on-resume = "brightnessctl --restore";
            }

            {
              timeout = 300; # 5 min
              on-timeout = "hyprlock";
            }
          ]
          ++ (
            if config.device.keyboardBacklight.available then
              [
                {
                  timeout = 120; # 2 min
                  on-timeout = "brightnessctl --save --device ${config.device.keyboardBacklight.id} set 0";
                  on-resume = "brightnessctl --restore --device ${config.device.keyboardBacklight.id}";
                }
              ]
            else
              [ ]
          );
        };
      };
    };
  };
}
