# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override { selected_themes = [ "spin" ]; })
      ];
      theme = "spin";
    };
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # enable garbage collection
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 14d";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      desktopManager.xterm.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.options = "compose:caps,caps:none";
    };

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Enable sound.
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = true;
        PermitRootLogin = "no";
      };
    };
  };

  services = {
    # Enable CUPS to print documents.
    printing = {
      enable = true;
      openFirewall = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    tailscale.enable = true;
    pulseaudio.enable = false;
    pcscd.enable = true;
  };

  programs = {
    fish.enable = true;
    starship.enable = true;
    java = {
      enable = true;
      package = pkgs.temurin-jre-bin-17;
    };
    nix-ld.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matz = {
    description = "Mathias Graf";
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "pw123";
    extraGroups = [
      "wheel"
      "lp"
      "scanner"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
    ];
  };

  # set env variables
  environment.sessionVariables = {
    # tell electron apps to use wayland
    ELECTRON_OZONE_PLATFORM_HINT = "X11"; # changed to x11 (xwayland) because wayland rendering is extremely glitchy at the moment
    OZONE_PLATFORM = "X11";
    ELECTRON_ENABLE_WAYLAND = "0";

    NIXOS_OZONE_WL = "0";
    # tell gdk apps to use wayland
    GDK_BACKEND = "wayland";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    alacritty
    bat
    bluez
    bluez-tools
    btop
    busybox
    choose
    chromium
    conda
    curl
    darktable
    delta
    docker
    eog
    evince
    fd
    file
    fish
    font-awesome
    fzf
    gimp3
    git
    glow
    hunspellDicts.de_CH
    hunspellDicts.en_US
    imagemagick
    imv
    inkscape
    jdk17
    jq
    just
    kdePackages.okular
    keepassxc
    kitty
    libqalculate
    libreoffice
    meld
    nixfmt
    nmap
    obs-studio
    pandoc
    pavucontrol
    pcre
    playerctl
    plymouth
    polkit
    pre-commit
    qutebrowser
    ripgrep
    ruff
    signal-desktop
    simple-scan
    slack
    starship
    tealdeer
    texliveFull
    tmux
    typst
    unzip
    vlc
    wget
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    zathura
    zip
    zotero
    zoxide
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # List services that you want to enable:

  xdg.portal = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
  ];

  security.pam.services = {
    hyprlock = { };
    login.enableGnomeKeyring = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  hardware = {
    enableAllFirmware = true;

    printers.ensurePrinters = [
      {
        name = "SEC8425195978E8";
        deviceUri = "ipp://192.168.1.88/ipp/print";
        model = "drv:///sample.drv/generic.ppd";
      }
    ];

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
    };

    # for scanners
    sane = {
      enable = true;
      extraBackends = [
        pkgs.sane-airscan
        pkgs.hplipWithPlugin
      ];
    };

    graphics.enable = true;
  };

  services.udev.packages = [ pkgs.sane-airscan ];

  # Open ports in the firewall
  networking.firewall.allowedTCPPorts = [ 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
