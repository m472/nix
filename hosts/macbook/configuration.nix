{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./../../configuration.nix ];
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
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  networking.hostName = "nixos-macbook"; # Define your hostname.
}
