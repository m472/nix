_: {
  imports = [ ./../../home.nix ];

  programs = {
    ssh = {
      matchBlocks = {
        calculon = {
          hostname = "calculon.informatik.fhnw.ch";
          user = "mathias";
          setEnv = {
            TERM = "xterm-256color";
          };
        };
        deepsignature_demo = {
          hostname = "147.86.10.164";
          user = "mathias";
        };
        deepsignature_test = {
          hostname = "deepsignature.ch";
          user = "mathias";
        };
        ikt = {
          hostname = "10.95.65.152";
          user = "smart";
          setEnv = {
            TERM = "xterm-256color";
          };
        };
      };
    };
  };

  # hyprland options
  device = {
    touchpad = {
      available = true;
      id = "asue120d:00-04f3:31fb-touchpad";
    };

    keyboardBacklight = {
      available = true;
      id = "asus::kbd_backlight";
    };

    battery = {
      available = true;
      id = "BAT1";
      fullAt = 73;
    };
  };
}
