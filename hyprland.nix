{ pkgs, config, ... }:
let
  scratchpadsize = "40% 50%";
  backgroundFile = "${config.xdg.configHome}/hypr/background.png";
in {
  home.packages = with pkgs; [
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
    touchpadctl
    waybar
    wev
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      monitor = [ ",preferred,auto,auto" "eDPI-1,2650x1600@60,0x0,1.4" ];

      exec-once = [
        "waybar"
        "pypr"
        "hyprpaper"
        "hypridle"
        "touchpadctl enable"
        "[workspace 1 silent] kitty"
        "[workspace 2 silent] qutebrowser"
        "[workspace 5 silent] signal-desktop"
      ];

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
        workspace_swipe = "off";
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
        "$mainMod, W, fullscreen, 1"

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

        ", XF86TouchpadToggle, exec, touchpadctl toggle"
        "$mainMod, T, exec, touchpadctl toggle"

        ''
          , Print, exec, grim "$(xdg-user-dir PICTURES)/$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')"''
        ''
          Mod1, Print, exec, grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible? and .focused) | .rect | "(.x),(.y) (.width)x(.height)"')" "$(xdg-user-dir PICTURES)/$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')"''
      ];

      # The "binde" bindings are repeated if the key is held down
      binde = [
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

        ", XF86KbdBrightnessDown, exec, brightnessctl --device=apple::kbd_backlight set 10%-"
        ", XF86KbdBrightnessUp, exec, brightnessctl --device=apple::kbd_backlight set +10%"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ .05+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ .05-"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod SHIFT, mouse:272, resizewindow"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 20;

        modules-left =
          [ "hyprland/mode" "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "custom/logo" "clock" ];
        modules-right = [
          "backlight"
          "cpu"
          "pulseaudio"
          "network"
          "custom/screenshot"
          "idle_inhibitor"
          "custom/touchpad"
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
            "6" = " ";
            "7" = "";
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
          format-wifi = "{signalStrength}% ";
          format-ethernet = "{ifname} ";
          tooltip-format = "{ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "nmcli device wifi list --rescan yes";
        };
        bluetooth = {
          format = " {status}";
          format-disabled = "";
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
          on-click = ''grim -g "$(slurp)"'';
          tooltip-format = "Take screenshot";
        };
        "custom/touchpad" = {
          format = "{}";
          interval = 10;
          exec = "touchpadctl barstatus '󰟸 ' '󰤳 '";
          on-click = "touchpadctl toggle";
          tooltip-format = "";
        };
      };
    };
    style = builtins.readFile ./config/waybar/style.css;
  };

  programs.pyprland = {
    enable = true;
    config = {
      pyprland = { plugins = [ "scratchpads" ]; };

      scratchpads.keepass = {
        animation = "fromTop";
        margin = 50;
        command = "keepassxc";
        lazy = true;
      };
    };
  };

  services.dunst = {
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

  home.file."${config.xdg.configHome}/rofi/config.rasi" = {
    enable = true;
    text = builtins.readFile ./config/rofi/config.rasi;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [ backgroundFile ];
      wallpaper = [ "eDP-1,${backgroundFile}" ];
    };
  };

  home.file."${backgroundFile}" = {
    enable = true;
    source = ./files/background.png;
  };
}
