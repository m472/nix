require("defs")

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
end)

local ipc = "noctalia msg "

hl.bind(MainMod .. " + D", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(MainMod .. " + P", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(MainMod .. " + C", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
