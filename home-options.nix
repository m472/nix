{
  lib,
  options,
  ...
}:
{
  options = {
    device = {

      touchpad = {
        available = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        id = lib.mkOption { type = lib.types.str; };
      };

      keyboardBacklight = {
        available = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        id = lib.mkOption { type = lib.types.str; };
      };

      battery = {
        available = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        id = lib.mkOption {
          type = lib.types.str;
          default = "BAT0";
        };
        fullAt = lib.mkOption {
          type = lib.types.int;
          default = 100;
        };
      };
    };
  };
}
