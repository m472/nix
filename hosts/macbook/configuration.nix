{ pkgs, ... }:

{
  import = [
    "${
      builtins.fetchGit {
        url = "https://github.com/NixOS/nixos-hardware.git";
        rev = "b55712de78725c8fcde422ee0a0fe682046e73c3";
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

  networking.hostName = "nixos-macbook"; # Define your hostname.
}
