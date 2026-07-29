local terminal    = "ghostty"
local fileManager = "nautilus"
local menu        = "~/dotfiles/rofi/launchers/launcher.sh"

local mainMod = "SUPER"

local keymap  = function (key)
    return mainMod .. " + " .. key
end

hl.bind(keymap("Q"), hl.dsp.exec_cmd(terminal))
hl.bind(keymap("W"), hl.dsp.exec_cmd("killall -9 waybar && waybar & disown"))
hl.bind(keymap("E"), hl.dsp.exec_cmd(fileManager))
hl.bind(keymap("R"), hl.dsp.exec_cmd(menu))

hl.bind(keymap("C"), hl.dsp.window.close())
hl.bind(keymap("V"), hl.dsp.exec_cmd("~/dotfiles/rofi/clipboards/launcher.sh"))

hl.bind(keymap("J"), hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(keymap("M"), hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Move focus with mainMod + arrow keys
hl.bind(keymap("left"),  hl.dsp.focus({ direction = "left" }))
hl.bind(keymap("right"), hl.dsp.focus({ direction = "right" }))
hl.bind(keymap("up"),    hl.dsp.focus({ direction = "up" }))
hl.bind(keymap("down"),  hl.dsp.focus({ direction = "down" }))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(keymap(key),             hl.dsp.focus({ workspace = i}))
    hl.bind(keymap("SHIFT + " .. key),     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(keymap("S"),         hl.dsp.workspace.toggle_special("magic"))
hl.bind(keymap("SHIFT + S"), hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(keymap("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(keymap("mouse_up"),   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(keymap("mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(keymap("mouse:273"), hl.dsp.window.resize(), { mouse = true })

hl.bind(keymap("ALT + R"), hl.dsp.submap("resize"))

hl.define_submap("resize", function ()
    hl.bind("right", hl.dsp.window.resize({x = 10, y = 0, relative = true}), {repeating = true})
    hl.bind("left", hl.dsp.window.resize({x = -10, y = 0, relative = true}), {repeating = true})
    hl.bind("up", hl.dsp.window.resize({x = 10, y = 0, relative = true}), {repeating = true})
    hl.bind("down", hl.dsp.window.resize({x = 10, y = 0, relative = true}), {repeating = true})

    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +2 --max-volume 150"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -2"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("swayosd-client --device amdgpu_bl1 --brightness +10"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("swayosd-client --device amdgpu_bl1 --brightness -10"),                  { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessUp",  hl.dsp.exec_cmd("swayosd-client --device asus::kbd_backlight --brightness +33"),                  { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessDown",hl.dsp.exec_cmd("swayosd-client --device asus::kbd_backlight --brightness -33"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
