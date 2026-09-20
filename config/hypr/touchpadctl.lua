require("defs")


hl.on("hyprland.start", function()
    hl.exec_cmd("touchpadctl enable " .. TouchpadDevice)
end)

hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("touchpadctl toggle " .. TouchpadDevice))
hl.bind(MainMod .. " + T", hl.dsp.exec_cmd("touchpadctl toggle " .. TouchpadDevice))
