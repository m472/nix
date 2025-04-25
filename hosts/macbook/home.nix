_: {
  imports = [ ./../../home.nix ];

  # hyprland options
  device = {
    touchpad = {
      available = true;
      id = "apple-inc.-apple-internal-keyboard-/-trackpad-1";
    };

    keyboardBacklight = {
      available = true;
      id = "apple::kbd_backlight";
    };

    battery = {
      available = true;
      id = "BAT0";
      fullAt = 87;
    };
  };

  hyprland.specificMonitorConfigs = [ "eDPI-1,2650x1600@60,0x0,1.4" ];
}
