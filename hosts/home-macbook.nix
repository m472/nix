_: {
  imports = [ ./../home.nix ];

  # hyprland options
  device = {
    touchpadId = "bcm5974";
    backlightDevice = "apple::kbd_backlight";
    battery = {
      available = true;
      id = "BAT0";
      fullAt = 87;
    };
  };
}
