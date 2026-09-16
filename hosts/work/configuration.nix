_:

{
  imports = [
    ./hardware-configuration.nix
    ./../../configuration.nix
  ];
  networking.hostName = "nixos-work"; # Define your hostname.
}
