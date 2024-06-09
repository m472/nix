_:

{
  imports = [ ./hardware-configuration-desktop.nix ./../configuration.nix ];
  networking.hostName = "nixos-desktop"; # Define your hostname.
}
