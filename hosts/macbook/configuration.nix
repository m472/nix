{ pkgs, ... }:

{
  imports = [
    "${
      builtins.fetchGit {
        url = "https://github.com/NixOS/nixos-hardware.git";
        rev = "9a049b4a421076d27fee3eec664a18b2066824cb";
      }
    }/apple/t2"
    ./hardware-configuration.nix
    ./../../configuration.nix
  ];
  # Wifi firmware for macbook
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "brcm-firmware";

      buildCommand = ''
        dir="$out/lib/firmware"
        mkdir -p "$dir"
        cp -r ${./firmware}/* "$dir"
      '';
    })
  ];

  boot.extraModprobeConfig = ''
    options hid_apple swap_fn_leftctrl=1 swap_opt_cmd=1
  '';

  # suspend does not work correctly on my macbook
  services.logind.lidSwitch = "ignore";

  networking.hostName = "nixos-macbook"; # Define your hostname.
}
