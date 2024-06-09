{ pkgs, lib, config, ... }:
let
  scratchpadsize = "40% 50%";
  backgroundFile = "${config.xdg.configHome}/hypr/background.png";
  screenshotFilepath =
    "$(xdg-user-dir PICTURES)/$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')";
  screenshotCommand =
    ''grim -g "$(slurp)" - | tee ${screenshotFilepath} | wl-copy'';
in {
  options = {
    device = {

      touchpad = {
        available = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        id = lib.mkOption { type = lib.types.str; };
      };

      keyboardBacklight = {
        available = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        id = lib.mkOption { type = lib.types.str; };
      };

      battery = {
        available = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        id = lib.mkOption {
          type = lib.types.str;
          default = "BAT0";
        };
        fullAt = lib.mkOption {
          type = lib.types.int;
          default = 100;
        };
      };
    };
    hyprland.specificMonitorConfigs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = {
    home = {
      packages = with pkgs;
        [
          brightnessctl
          dunst
          grim
          hyprland
          hypridle
          hyprlock
          hyprpaper
          papirus-icon-theme
          pyprland
          rofi-power-menu
          rofi-wayland
          slurp
          waybar
          wev
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-wlr
        ]
        ++ (if config.device.touchpad.available then [ touchpadctl ] else [ ]);
      file = {
        "${config.xdg.configHome}/rofi/config.rasi" = {
          enable = true;
          source = ./config/rofi/config.rasi;
        };

        "${backgroundFile}" = {
          enable = true;
          source = ./files/background.png;
        };

        "${config.xdg.configHome}/hypr/pyprland.toml" = {
          enable = true;
          source = ./config/hypr/pyprland.toml;
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {

        monitor = config.hyprland.specificMonitorConfigs
          ++ [ ",preferred,auto,auto" ];

        exec-once = [
          "waybar"
          "pypr"
          "hypridle"
          "hyprpaper"
          "[workspace 1 silent] kitty"
          "[workspace 2 silent] qutebrowser"
          "[workspace 5 silent] signal-desktop"
        ] ++ (if config.device.touchpad.available then
          [ "touchpadctl enable ${config.device.touchpad.id}" ]
        else
          [ ]);

        xwayland = { force_zero_scaling = true; };

        input = {
          kb_layout = "us";
          kb_options = "compose:caps,caps:none";
          follow_mouse = 1;
          touchpad = { natural_scroll = "no"; };
        };

        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
        };

        decoration = {
          rounding = 4;
          drop_shadow = "yes";
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile =
            "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = "yes"; # you probably want this
        };

        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true;
        };

        gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = "on";
        };

        "$mainMod" = "SUPER";

        "$scratchpad" = "class:^(scratchpad)$";
        "$keepassClass" = "class:^(keepassxc)$";
        windowrulev2 = [
          # general
          "float,$scratchpad"
          "size ${scratchpadsize},$scratchpad"
          "workspace special silent,$scratchpad"
          "center,$scratchpad"

          # keepass
          "float,$keepassClass"
          "size ${scratchpadsize},$keepassClass"
          "workspace special silent,$keepassClass"
          "center,$keepassClass"
        ];

        bind = [
          "$mainMod, return, exec, kitty"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod SHIFT, E, exit,"
          "$mainMod, space, togglefloating,"
          "$mainMod, D, exec, rofi -show drun"
          ''$mainMod, P, exec, rofi -show menu -modi "menu:rofi-power-menu"''
          "$mainMod, E, togglesplit, # dwindle"
          "$mainMod, R, resizeactive, # dwindle"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, J, movefocus, u"
          "$mainMod, K, movefocus, d"
          "$mainMod, F, fullscreen, 0"
          "$mainMod SHIFT, P, pin, "
          "$mainMod, W, fullscreen, 1"
          "$mainMod SHIFT, S, swapactiveworkspaces, 0 1"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # move active window
          "$mainMod SHIFT, H, swapwindow, l"
          "$mainMod SHIFT, L, swapwindow, r"
          "$mainMod SHIFT, J, swapwindow, d"
          "$mainMod SHIFT, K, swapwindow, u"

          # move workspace to monitor
          "$mainMod CTRL SHIFT, L, movecurrentworkspacetomonitor, r"
          "$mainMod CTRL SHIFT, H, movecurrentworkspacetomonitor, l"
          "$mainMod CTRL SHIFT, J, movecurrentworkspacetomonitor, d"
          "$mainMod CTRL SHIFT, K, movecurrentworkspacetomonitor, u"

          "$mainMod CTRL SHIFT, right, movecurrentworkspacetomonitor, r"
          "$mainMod CTRL SHIFT, left, movecurrentworkspacetomonitor, l"
          "$mainMod CTRL SHIFT, down, movecurrentworkspacetomonitor, d"
          "$mainMod CTRL SHIFT, up, movecurrentworkspacetomonitor, u"

          # Toggle keepass scratchpad
          "$mainMod, minus, exec, pypr toggle keepass"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          # Set up media keys
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"

          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPlay, exec, playerctl play-pause"

          ", XF86LaunchA, exec, rofi -show window"

          ", Print, exec, ${screenshotCommand}"
        ] ++ (if config.device.touchpad.available then [
          ", XF86TouchpadToggle, exec, touchpadctl toggle ${config.device.touchpad.id}"
          "$mainMod, T, exec, touchpadctl toggle ${config.device.touchpad.id}"
        ] else
          [ ]);

        # The "binde" bindings are repeated if the key is held down
        binde = [
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ .05+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ .05-"
        ] ++ (if config.device.keyboardBacklight.available then [

          ", XF86KbdBrightnessDown, exec, brightnessctl --device=${config.device.keyboardBacklight.id} set 10%-"
          ", XF86KbdBrightnessUp, exec, brightnessctl --device=${config.device.keyboardBacklight.id} set +10%"
        ] else
          [ ]);

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod SHIFT, mouse:272, resizewindow"
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

            modules-left =
              [ "hyprland/mode" "hyprland/workspaces" "hyprland/window" ];
            modules-center = [ "custom/logo" "clock" ];
            modules-right =
              [ "backlight" "pulseaudio" "mpris" "network" "custom/screenshot" ]
              ++ (if config.device.touchpad.available then
                [ "custom/touchpad" ]
              else
                [ ]) ++ [ "idle_inhibitor" "battery" ];
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
              format = "{icon} {}";
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
              format-icons = [ "" "" "" "" "" ];
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
              tooltip-format-enumerate-connected =
                "{device_alias}	{device_address}";
            };
            pulseaudio = {
              format = "{icon}";
              format-muted = "";
              format-icons = {
                phone = [ " " " " " " ];
                default = [ "" "" "" ];
              };
              scroll-step = 1;
              on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            };
            backlight = {
              format = "{percent}% {icon}";
              format-icons = [ "" "" ];
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
              status-icons = { paused = "⏸"; };
            };
          } // (if config.device.touchpad.available then {
            "custom/touchpad" = {
              format = "{}";
              interval = 10;
              exec = "touchpadctl barstatus '󰟸 ' '󰤳 '";
              on-click =
                "touchpadctl toggle --device ${config.device.touchpad.id}";
              tooltip-format = "";

            };
          } else
            { });
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

          background = [{
            monitor = "";
            path = "${config.xdg.configHome}/hypr/background.png";
          }];

          input-field = [{
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
          }];

          label = [
            {
              monitor = "";
              text = "$TIME";
              text_align = "center";
              font_size = 100;
              position = "0, -100";
              halign = "center";
              valign = "center";
            }

            {
              monitor = "";
              text = "";
              text_align = "center";
              color = "rgba(0, 179, 179, 50)";
              font_size = 250;
              position = "0, 200";
              halign = "center";
              valign = "center";
            }

            {
              monitor = "";
              text = ''
                cmd[update: 10000] echo -e "󰂎  $(upower -i /org/freedesktop/UPower/devices/battery_${config.device.battery.id} | rg "percentage:" | choose 1 | sed 's/%//' | cut --delimiter '.' --fields 1)%\n$(cat /sys/class/power_supply/${config.device.battery.id}/status)"'';
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
          global = { corner_radius = 6; };

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
          general = { lock_cmd = "hyprlock"; };
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
          ] ++ (if config.device.keyboardBacklight.available then [{
            timeout = 120; # 2 min
            on-timeout =
              "brightnessctl --save --device ${config.device.keyboardBacklight.id} set 0";
            on-resume =
              "brightnessctl --restore --device ${config.device.keyboardBacklight.id}";
          }] else
            [ ]);
        };
      };
    };
  };
}
