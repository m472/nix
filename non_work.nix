{ pkgs, ... }:
{
  users.users.flavia = {
    description = "Flavia Bindschedler";
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "pw123";
  };

  services = {
    tailscale.enable = true;

    mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };
  };
}
