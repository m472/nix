_:

{
  imports = [ ./hardware-configuration.nix ./../../configuration.nix ];
  networking.hostName = "nixos-desktop"; # Define your hostname.
}
