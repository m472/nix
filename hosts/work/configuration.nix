{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../configuration.nix
    ./../../virtualbox.nix
    ./../../work.nix
  ];
  networking.hostName = "nixos-work"; # Define your hostname.

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
