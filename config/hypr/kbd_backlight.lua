require("defs")

local base_cmd = "brightnessctl --device=" .. KbdBacklightDevice

hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(base_cmd .. " set 10%-"))
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd(base_cmd .. " set +10%"))
