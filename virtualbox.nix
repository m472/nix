_: {
  users = {
    extraGroups.vboxusers.members = [ "matz" ];
  };

  # apparently "kvm-amd" has to be disabled for VirtualBox to work
  boot.blacklistedKernelModules = [ "kvm-amd" ];

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
}
