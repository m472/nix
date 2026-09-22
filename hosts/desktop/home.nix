_: {
  imports = [ ./../../home.nix ];

  hyprland.specificMonitorConfigs = [
    "DVI-I-1,1920x1080@60,1920x0,1.0"
    "DVI-D-1,1920x1080@60,0x0,1.0"
  ];

  services.shikane.settings.profile = [
    {
      name = "desktop";
      output = [
        {
          enable = true;
          search = [
            "m=ASUS VS247"
            "s=D6LMTF079392"
            "v="
          ];
          position = "1920,0";
          mode = "1920x1080@60Hz";
        }
        {
          enable = true;
          search = [
            "m=ASUS VS247"
            "s=D6LMTF079389"
            "v="
          ];
          position = "0,0";
          mode = "1920x1080@60Hz";
        }
      ];
    }
  ];
}
