{ config, pkgs, ... }:

{
  environment.variables = { HOME_MANAGER_MANAGES_NVIM = "true"; };

  home-manager.users.matz = { pkgs, ... }: {
    home.username = "matz";
    home.homeDirectory = "/home/matz";

    programs.git = {
      enable = true;
      userName = "Mathias Graf";
      userEmail = "mathias.n.graf@gmail.com";
      extraConfig = {
        core = { editor = "nvim"; };

        merge = { tool = "meld"; };

        init = { defaultBranch = "main"; };
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        vim-sensible
        nvim-surround
        vim-repeat
        vim-commentary
        undotree
        gruvbox-nvim
        tagbar
        popup-nvim
        telescope-nvim
        plenary-nvim
        nvim-tree-lua
        nvim-treesitter
        nvim-treesitter-context
        nvim-treesitter-parsers.yaml
        nvim-treesitter-parsers.nix
        nvim-treesitter-parsers.python
        nvim-treesitter-parsers.haskell
        nvim-treesitter-parsers.rust
        nvim-treesitter-parsers.toml
        nvim-treesitter-parsers.markdown
        nvim-treesitter-parsers.vim
        nvim-treesitter-parsers.lua
        nvim-treesitter-parsers.fish
        nvim-treesitter-parsers.ssh_config
        nvim-treesitter-parsers.rst
        nvim-treesitter-parsers.r
        nvim-treesitter-parsers.make
        nvim-treesitter-parsers.latex
        nvim-treesitter-parsers.julia
        nvim-treesitter-parsers.json
        nvim-treesitter-parsers.dockerfile
        nvim-treesitter-parsers.csv
        nvim-treesitter-parsers.bibtex
        nvim-treesitter-parsers.bash
        lualine-nvim
        nvim-web-devicons
        mason-nvim
        mason-lspconfig-nvim
        trouble-nvim
        nvim-cmp
        cmp-path
        cmp-buffer
        cmp-cmdline
        cmp-nvim-lsp
      ];
    };

    programs.qutebrowser = {
      enable = true;
      keyBindings = {
        normal = {
          "J" = "tab-prev";
          "K" = "tab-next";
        };
      };
      extraConfig = ''
        c.zoom.default = '75%'
        c.aliases["chromium"] = "spawn --detach chromium --app={url} --disable-extensions;; tab-close"
      '';

      searchEngines = {
        py = "https://pypi.org/search/?q={}";
        wiki =
          "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
        np =
          "https://search.nixos.org/packages?channel=23.11&from=0&size=50&sort=relevance&type=packages&query={}";
      };
    };

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      shellAbbrs = {
        nv = "nvim";
        Ga = "git add";
        Gap = "git add -p";
        Gc = "git commit";
        Gcm = "git commit -m";
        Gd = "git diff";
        Gds = "git diff --staged";
        Gs = "git status";
        Gl = "git log";
        Gpl = "git pull";
        Gph = "git push";
        sl = "ls";
      };
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd cd" ];
    };

    programs.kitty = {
      enable = true;
      font.name = "FiraCode-Regular";
      font.size = 10;
      settings = {
        scrollback_lines = 40000;
        font_features = "FiraCode-Regular +ss05";
        enable_audio_bell = false;
        window_padding_width = "2 5";

        # Gruvbox Dark theme, author: Pavel Pertsev, license: MIT/X11
        selection_foreground = "#ebdbb2";
        selection_background = "#d65d0e";

        background = "#282828";
        foreground = "#ebdbb2";

        color0 = "#3c3836";
        color1 = "#cc241d";
        color2 = "#98971a";
        color3 = "#d79921";
        color4 = "#458588";
        color5 = "#b16286";
        color6 = "#689d6a";
        color7 = "#a89984";
        color8 = "#928374";
        color9 = "#fb4934";
        color10 = "#b8bb26";
        color11 = "#fabd2f";
        color12 = "#83a598";
        color13 = "#d3869b";
        color14 = "#8ec07c";
        color15 = "#fbf1c7";

        cursor = "#bdae93";
        cursor_text_color = "#665c54";

        url_color = "#458588";

      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [ ",preferred,auto,auto" "eDPI-1,2650x1600@60,0x0,1.4" ];
        exec-once = "waybar";
        xwayland = { force_zero_scaling = true; };
        input = {
          kb_layout = "us";
          kb_options = "compose:caps,caps:none,shift:both_capslock";
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

        bind = [
          "$mainMod, return, exec, kitty"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod SHIFT, E, exit,"
          "$mainMod, space, togglefloating,"
          "$mainMod, D, exec, wofi --show drun"
          "$mainMod, P, pseudo, # dwindle"
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
          "$mainMod SHIFT, minus, movetoworkspace, special"
          "$mainMod, minus, togglespecialworkspace"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          
          # Set up media keys
            ", XF86MonBrightnessDown, exec, light -U 5"
            ", XF86MonBrightnessUp, exec, light -A 5"

            ", XF86KbdBrightnessDown, exec, light -s sysfs/leds/samsung::kbd_backlight -U 10"
            ", XF86KbdBrightnessUp, exec, light -s sysfs/leds/samsung::kbd_backlight -U 10"

            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ .05+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ .05-"

            ", XF86AudioPrev, exec, playerctl previous"
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPlay, exec, playerctl play-pause"

            ", XF86TouchpadToggle, exec, swaymsg input type:touchpad events toggle"

            ", Print, exec, grim \"$(xdg-user-dir PICTURES)/$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')\""
            "Mod1, Print, exec, grim -g \"$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible? and .focused) | .rect | \"\(.x),\(.y) \(.width)x\(.height)\"')\" \"$(xdg-user-dir PICTURES)/$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')\""
        ];

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
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
            "bluetooth"
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
            format-alt = "{volume} {icon}";
            format-alt-click = "click-right";
            format-muted = "";
            format-icons = {
              phone = [ " " " " " " ];
              default = [ "" "" "" ];
            };
            scroll-step = 1;
            on-click = "pavucontrol";
          };
          backlight = {
            device = "intel_backlight";
            format = "{percent}% {icon}";
            format-icons = [ "" "" ];
            on-scroll-down = "light -A 5";
            on-scroll-up = "light -A 5";
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          "wlr/taskbar" = {
            format = "{icon}";
            icon-size = 14;
            icon-theme = "Numix-Circle";
            tooltip-format = "{title}";
            on-click = "activate";
            on-click-middle = "close";
          };
          "custom/screenshot" = {
            format = "";
            on-click = ''grim -g "$(slurp)"'';
            tooltip-format = "Take screenshot";
          };
        };
      };
      style = fetchTree{
        type = "file";
        url = "file:///etc/nixos/config/waybar/style.css";
      };
    };

    services.dunst.enable = true;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.11";
  };
}
