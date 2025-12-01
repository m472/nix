_:

{
  imports = [
    ./hardware-configuration.nix
    ./../../configuration.nix
    ./../../remote-builder.nix
  ];
  networking.hostName = "nixos-desktop"; # Define your hostname.

  programs.steam = {
    enable = true;
  };
}
