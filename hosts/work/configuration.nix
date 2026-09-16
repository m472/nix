_:

{
  imports = [
    ./hardware-configuration.nix
    ./../../configuration.nix
    ./../../virtualbox.nix
  ];
  networking.hostName = "nixos-work"; # Define your hostname.
}
