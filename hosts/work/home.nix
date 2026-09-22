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

  services.shikane.settings.profile =
    let
      internalSearch = [
        "v=BOE"
        "m=0x0A55"
      ];
      internalMode = "2560x1440@240.003Hz";
      notify = ["notify-send shikane \"Profile $SHIKANE_PROFILE_NAME has been applied\""];
    in
    [
      {
        name = "clamshell";
        exec = notify;
        output = [
          {
            search = internalSearch;
            enable = false;
            mode = internalMode;
            position = "0,0";
          }
          {
            search = [ "s=CNC60202C8" ];
            enable = true;
            mode = "3440x1440";
            position = "3440,0";
            scale = 1.0;
          }
        ];
      }
      {
        name = "internal only";
        exec = notify;
        output = [
          {
            search = internalSearch;
            enable = true;
            mode = internalMode;
            position = "0,0";
          }
          {
            search = [ "n=fallback" ];
            enable = false;
          }
        ];
      }
      {
        name = "Meeting Room 5.2A32";
        exec = notify;
        output = [
          {
            enable = true;
            search = internalSearch;
            mode = internalMode;
          }
          {
            enable = true;
            search = [
              "m=SAMSUNG"
              "s=H1AK500000"
            ];
            mode = "3840x2160@30Hz";
            position = "3840,0";
            scale = 2;
          }
        ];
      }
      {
        name = "Classroom";
        exec = notify;
        output = [
          {
            enable = true;
            search = internalSearch;
            mode = internalMode;
            position = "0,0";
          }
          {
            enable = true;
            search = [
              "m=Univ_HDMI_PCM"
              "s="
              "v=Lightware Visual Engineering"
            ];
            mode = "1920x1080@50Hz";
            position = "2560,0";
            scale = 1.0;
            transform = "normal";
            adaptive_sync = false;
          }
        ];
      }
    ];
}
