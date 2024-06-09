_: {
  imports = [ ./../home.nix ];

  # hyprland options
  device = {
    touchpad = {
      available = true;
      id = "bcm5974";
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
}
