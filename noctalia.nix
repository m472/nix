_: {
  config = {
    programs = {
      noctalia = {
        enable = true;
        settings = builtins.readFile ./config/noctalia-config.toml;
      };
    };
    wayland.windowManager.hyprland.extraLuaFiles.noct.content = ./config/hypr/noctalia.lua;
  };
}
