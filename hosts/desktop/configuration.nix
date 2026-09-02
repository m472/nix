_:

{
  imports = [
    ./hardware-configuration.nix
    ./../../configuration.nix
    ./../../remote-builder.nix
  ];
  networking.hostName = "nixos-desktop"; # Define your hostname.

  boot.kernelParams = [
    "radeon.si_support=0"
    "amdgpu.si_support=1"
    "radeon.cik_support=0"
    "amdgpu.cik_support=1"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  programs.steam = {
    enable = true;
  };
}
