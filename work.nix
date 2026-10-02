{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zotero
    slack
  ];

  networking.interfaces.vboxnet0.ipv4.addresses = [
    {
      address = "192.168.56.1";
      prefixLength = 24;
    }
  ];
}
