local hl = _G.hl

-- https://wiki.hypr.land/Configuring/Basics/Binds/
-- https://wiki.hypr.land/Configuring/Basics/Dispatchers/

hl.bind("SUPER + A", hl.dsp.exec_cmd(MENU))
hl.bind("SUPER + T", hl.dsp.exec_cmd(TERMINAL))
hl.bind("SUPER + S", hl.dsp.exec_cmd(SCREENSHOT))

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen())

hl.bind("SUPER + F", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.center())

    local window = hl.get_active_window()
    local monitor = window and window.monitor or hl.get_active_monitor()

    if monitor == nil then
        return
    end

    hl.dispatch(hl.dsp.window.resize({
        x = math.floor(monitor.width * 0.6),
        y = math.floor(monitor.height * 0.9),
        relative = false,
    }))
end)

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + tab", hl.dsp.focus({ monitor = "+1" }))
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + tab", function()
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "bottom" }))
    hl.dispatch(hl.dsp.window.cycle_next())
end)

-- Switch workspaces with SUPER + [0-9]
for i = 1, 9 do
    hl.bind("SUPER + " .. i,           hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. i,   hl.dsp.window.move({ workspace = i }))
end

-- Workspace 0 for Knuth
hl.bind("SUPER + 0",         hl.dsp.focus({ workspace = "name:Knuth" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "name:Knuth" }))

-- Toggle special workspace
hl.bind("CTRL + grave",      hl.dsp.workspace.toggle_special("Terminal"))

-- Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move/resize windows + Mouse
hl.bind("SUPER + Z", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + X", hl.dsp.window.resize(), { mouse = true })

-- Resize windows
hl.bind("SUPER + SHIFT + Right", hl.dsp.window.resize({ x = 30, y = 0 }),   { repeating = true })
hl.bind("SUPER + SHIFT + Left",  hl.dsp.window.resize({ x = -30, y = 0 }),  { repeating = true })
hl.bind("SUPER + SHIFT + Up",    hl.dsp.window.resize({ x = 0, y = -30 }),  { repeating = true })
hl.bind("SUPER + SHIFT + Down",  hl.dsp.window.resize({ x = 0, y = 30 }),   { repeating = true })

-- Clipboard
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | tofi -c ~/.config/tofi/configV | cliphist decode | wl-copy"))

-- Colour Picker
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))

-- Screen locking
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- vim-like arrow key sendshortcut
hl.bind("SUPER + H", hl.dsp.send_shortcut({ mods = "", key = "left" }))
hl.bind("SUPER + J", hl.dsp.send_shortcut({ mods = "", key = "down" }))
hl.bind("SUPER + K", hl.dsp.send_shortcut({ mods = "", key = "up" }))
hl.bind("SUPER + L", hl.dsp.send_shortcut({ mods = "", key = "right" }))

-- wlogout
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("pidof -q wlogout || wlogout"))

-- waybar
hl.bind("CTRL + Escape", hl.dsp.exec_cmd("pkill waybar || hyprctl 'dispatch hl.dsp.exec_cmd(\"waybar\")'"))

-- Screenshot
hl.bind("Print",            hl.dsp.exec_cmd("grimblast --notify copysave screen"))
hl.bind("SUPER + Print",    hl.dsp.exec_cmd("grimblast --notify copysave active"))
hl.bind("SUPER + ALT + Print", hl.dsp.exec_cmd("grimblast --notify copysave area"))

-- Volume and Media Control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pamixer --default-source -m"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"))

-- Screen brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))

