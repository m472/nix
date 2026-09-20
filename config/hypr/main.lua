require("defs")
---------------
-- Autostart --
---------------

hl.on("hyprland.start", function()
    hl.exec_cmd(Terminal)
    hl.exec_cmd("udiskie --notify")
    hl.exec_cmd("shikane")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("qutebrowser")
    hl.exec_cmd("signal-desktop --password-store=\"gnome-libsecret\" --ozone-platform=x11")
    hl.exec_cmd("slack")
    hl.exec_cmd("keepassxc")
end)

------------------
-- Window Rules --
------------------

hl.window_rule({
    name = "move-signal",
    match = { class = "signal" },
    workspace = "5 silent",
})
hl.window_rule({
    name = "move-slack",
    match = { class = "slack" },
    workspace = "5 silent",
})
hl.window_rule({
    name = "move-browser",
    match = { class = "org.qutebrowser.qutebrowser" },
    workspace = "2 silent",
})
hl.window_rule({
    name = "move-keepass",
    match = { class = "org.keepassxc.KeePassXC" },
    workspace = "special:keepass silent",
})
hl.window_rule({
    name = "move-keepass",
    match = { class = "org.gnome.Evince" },
    workspace = "4",
})
hl.window_rule({
    name = "move-keepass",
    match = { class = "gimp" },
    workspace = "7",
})
hl.window_rule({
    name = "move-keepass",
    match = { class = "org.gnome.Nautilus" },
    workspace = "7",
})
hl.window_rule({
    name = "move-keepass",
    match = { class = "firefox" },
    workspace = "4",
})

--------------
-- Monitors --
--------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

--------------
-- Env Vars --
--------------

hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

-----------
-- Input --
-----------
hl.config({
    input = {
        numlock_by_default = true,
        kb_layout          = "us",
        kb_options         = "compose:caps, caps:none",
        follow_mouse       = 1,
        touchpad           = {
            natural_scroll = false,
        },
    }
})

-------------
-- General --
-------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = 0x595959aa,
        },

        layout = "dwindle",
    },
    decoration = {
        rounding = 4,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0x1a1a1aee,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

-----------------
-- Keybindings --
-----------------


hl.bind(MainMod .. " + return", hl.dsp.exec_cmd(Terminal))
hl.bind(MainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(MainMod .. " + SHIFT + E", hl.dsp.exit())

hl.bind(MainMod .. " + space", hl.dsp.window.float({ action = "toggle" }))

local directions = {
    ["H"] = "left",
    ["L"] = "right",
    ["J"] = "up",
    ["K"] = "down",
}

-- move window focus
for key, dir in pairs(directions) do
    hl.bind(MainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
    hl.bind(MainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }))

    hl.bind(MainMod .. " + SHIFT + " .. key, hl.dsp.window.swap({ direction = dir }))
    hl.bind(MainMod .. " + SHIFT + " .. dir, hl.dsp.window.swap({ direction = dir }))

    hl.bind(MainMod .. " + CTRL + SHIFT + " .. key, hl.dsp.workspace.move({ monitor = dir }))
    hl.bind(MainMod .. " + CTRL + SHIFT + " .. dir, hl.dsp.workspace.move({ monitor = dir }))
end

-- Toggle keepass scratchpad
local special_workspaces = {
    ["minus"] = "keepass",
    ["code:21"] = "longrunning"
}

for key, name in pairs(special_workspaces) do
    hl.bind(MainMod .. " + " .. key, hl.dsp.workspace.toggle_special(name))
    hl.bind(MainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "special:" .. name }))
end

-- switch workspaces and move to workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(MainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(MainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


-- fullscreen and fake fullscreen
hl.bind(MainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(MainMod .. " + W", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(MainMod .. " + E", hl.dsp.layout("togglesplit"))
hl.bind(MainMod .. " + S", hl.dsp.layout("swapsplit"))

-- swap active workspaces
hl.bind(MainMod .. " + SHIFT + S", hl.dsp.workspace.swap_monitors({ monitor1 = 0, monitor2 = 1 }))

-- bind audio and brightness keys
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ .05+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ .05-"), { repeating = true })

-- mouse bindings
hl.bind(MainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- lid switch bindings
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ 1; brightnessctl --save set 0%"))
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("brightnessctl --restore"))
