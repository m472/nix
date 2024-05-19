{ config, pkgs, environment, ... }:

{
  imports = [ ./neovim.nix ];

  home = rec {
    username = "matz";
    homeDirectory = "/home/${username}";
    sessionVariables = { HOME_MANAGER_MANAGES_NVIM = "true"; };

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

  programs.git = {
    enable = true;
    userName = "Mathias Graf";
    userEmail = "mathias.n.graf@gmail.com";
    extraConfig = {
      core = {
        editor = "nvim";
        pager = "delta";
      };
      merge.tool = "meld";
      init.defaultBranch = "main";
      push.autoSetupRemote = "true";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        light = false;
      };
    };
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

  services.dunst.enable = true;
}
