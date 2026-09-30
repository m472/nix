require("defs")

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
end)

local ipc = "noctalia msg "

hl.bind(MainMod .. " + D", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(MainMod .. " + P", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /session "))
hl.bind(MainMod .. " + C", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))

hl.bind(MainMod .. " + A", hl.dsp.exec_cmd(ipc .. "annotate"))
hl.bind(MainMod .. " + B", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center bluetooth"))
hl.bind(MainMod .. " + M", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center media"))


-- notification stuff
local notification_submap = "notification"
hl.bind(MainMod .. " + N", function()
    hl.dispatch(hl.dsp.exec_cmd(ipc .. "panel-open control-center notifications"))
    hl.dispatch(hl.dsp.submap(notification_submap))
end)


local function dispatch_and_exit_submap(action)
    return function()
        hl.dispatch(action)
        hl.dispatch(hl.dsp.exec_cmd(ipc .. "panel-close control-center"))
        hl.dispatch(hl.dsp.submap("reset"))
    end
end

hl.define_submap(notification_submap, function()
    hl.bind("C", dispatch_and_exit_submap(hl.dsp.exec_cmd(ipc .. "notification-clear-history")))
    hl.bind("D", dispatch_and_exit_submap(hl.dsp.exec_cmd(ipc .. "notification-clear-active")))
    hl.bind("Q", hl.dsp.exec_cmd(ipc .. "notification-dnd-toggle"))

    for _, key in pairs({ "escape", "N", MainMod .. " + N" }) do
        hl.bind(key, dispatch_and_exit_submap(hl.dsp.no_op()))
    end
end)
