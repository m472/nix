# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override { selected_themes = [ "spin" ]; })
        ];
      theme = "spin";
    };
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

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

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      desktopManager.xterm.enable = true;

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.options = "compose:caps,caps:none";
    };

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
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    gnome.gnome-keyring.enable = true;
  };

  # Enable CUPS to print documents.
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  hardware.pulseaudio.enable = false;

  programs = {
    fish.enable = true;
    starship.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matz = {
    description = "Mathias Graf";
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "pw123";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ firefox tree ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    bat
    btop
    busybox
    choose
    chromium
    curl
    darktable
    delta
    docker
    eog
    evince
    fd
    fish
    font-awesome
    fzf
    gimp
    git
    hunspellDicts.de_CH
    hunspellDicts.en_US
    imagemagick
    imv
    inkscape
    jq
    just
    keepassxc
    kitty
    libqalculate
    libreoffice
    meld
    neovim
    nerdfonts
    nixfmt-classic
    nmap
    obs-studio
    pandoc
    pcre
    playerctl
    plymouth
    polkit
    pre-commit
    qutebrowser
    ripgrep
    ruff
    signal-desktop
    starship
    tealdeer
    tmux
    vlc
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    wget
    wl-clipboard
    zathura
    zotero
    zoxide
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # List services that you want to enable:

  xdg.portal = { enable = true; };

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) ];

  security.pam.services.hyprlock = { };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Open ports in the firewal.
  # networking.firewall.allowedTCPPorts = [ ... ];
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
