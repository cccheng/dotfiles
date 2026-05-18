--
-- ██╗  ██╗██╗   ██╗██████╗ ██████╗
-- ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗
-- ███████║ ╚████╔╝ ██████╔╝██████╔╝
-- ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗
-- ██║  ██║   ██║   ██║     ██║  ██║
-- ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝
--
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/
--

---------------------
---- MY PROGRAMS ----
---------------------

local TERMINAL     = "foot"
local MENU         = "tofi-drun"


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- hyprcursor
hl.env("XCURSOR_SIZE", "25")
hl.env("HYPRCURSOR_SIZE", "24")

-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Fcitx
-- https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

-- GTK
hl.env("GTK_THEME", "Adwaita:dark")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- Toolkit Backend Variables
-- https://wiki.archlinux.org/title/Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "preferred",
    position = "-1920x-1000",
    scale    = 1,
})


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 3,
        border_size = 1,

        col = {
            active_border   = { colors = {"rgb(8AADF4)", "rgb(24273A)", "rgb(24273A)", "rgb(8AADF4)"}, angle = 75 },
            inactive_border = { colors = {"rgb(24273A)", "rgb(24273A)", "rgb(24273A)", "rgb(27273A)"}, angle = 45 },
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 7,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled = true,
            size    = 5,
        },

        shadow = {
            enabled      = true,
            sharp        = false,
            range        = 10,
            render_power = 2,
            color        = "rgba(155,191,191,0.20)",
            color_inactive = "rgba(0,0,0,0)",
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animations
hl.animation({ leaf = "windows",          enabled = true, speed = 5, bezier = "default", style = "gnomed" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "default", style = "slidefadevert -50%" })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_rules   = "",

        kb_options = "caps:escape",

        -- 0 - Cursor movement will not change focus.
        follow_mouse = 0,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll       = true,
            disable_while_typing = true,
        },
    },

    dwindle = {
        -- The split (side/top) will not change regardless of what happens to the container.
        preserve_split = true,
    },

    master = {},

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = false,
        force_default_wallpaper  = 0,
        animate_manual_resizes   = true,
        mouse_move_enables_dpms  = true,
        key_press_enables_dpms   = true,
    },
})


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({ workspace = "name:Knuth", monitor = "eDP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "special:Terminal", on_created_empty = "[float; move (monitor_w*0.01) (monitor_h*0.038); size (monitor_w*0.98) (monitor_h*0.956)] " .. TERMINAL })

-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules
hl.layer_rule({
    name  = "waybar-slide",
    match = { namespace = "waybar" },
    animation = "slide",
})

hl.layer_rule({
    name  = "notifications-slide",
    match = { namespace = "notifications" },
    animation = "slide",
})

-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- windowrule to avoid idle for fullscreen apps
hl.window_rule({
    name  = "idle-inhibit-fullscreen",
    match = { fullscreen = true },
    idle_inhibit = "fullscreen",
})

hl.window_rule({
    name  = "no-blur-empty",
    match = { class = "^()$", title = "^()$" },
    no_blur = true,
})

hl.window_rule({
    name  = "opacity-qt-ct",
    match = { class = "^(qt5ct|qt6ct)$" },
    opacity = "0.90 0.80 1.00",
})

hl.window_rule({
    name  = "opacity-portal-gtk",
    match = { class = "^(org.freedesktop.impl.portal.desktop.gtk)$" },
    opacity = "0.90 0.80 1.00",
})

hl.window_rule({
    name  = "opacity-portal-hyprland",
    match = { class = "^(org.freedesktop.impl.portal.desktop.hyprland)$" },
    opacity = "0.90 0.80 1.00",
})

-- Floating tagged windows
hl.window_rule({
    name  = "tag-floating",
    match = { class = "^(nm-connection-editor|blueman-manager)$" },
    tag   = "+floating",
})

hl.window_rule({
    name  = "tag-floating-nwg",
    match = { class = "^(nwg-look|nwg-display)$" },
    tag   = "+floating",
})

hl.window_rule({
    name         = "floating-tagged",
    match        = { tag = "floating" },
    float        = true,
    opacity      = "0.90 0.80 1.00",
    border_color = "rgba(BCA4E0aa)",
})

-- Media player
hl.window_rule({
    name  = "tag-media-player",
    match = { class = "^([Mm]pv|vlc)$" },
    tag   = "+media-player",
})

hl.window_rule({
    name    = "media-player-props",
    match   = { tag = "media-player" },
    float   = true,
    opaque  = true,
    content = "video",
})

-- Image viewer
hl.window_rule({
    name  = "tag-image-viewer",
    match = { class = "^(imv|feh)$" },
    tag   = "+image-viewer",
})

hl.window_rule({
    name       = "image-viewer-props",
    match      = { tag = "image-viewer" },
    float      = true,
    opaque     = true,
    fullscreen = true,
    content    = "photo",
})

-- Terminal
hl.window_rule({
    name  = "tag-terminal",
    match = { class = "^(Alacritty|kitty|rio)$" },
    tag   = "+terminal",
})

hl.window_rule({
    name     = "terminal-props",
    match    = { tag = "terminal" },
    rounding = 3,
    opacity  = "0.97 0.90 1.00",
})

-- File browser
hl.window_rule({
    name  = "tag-file-browser",
    match = { class = "^(org.gnome.Nautilus|[Tt]hunar)$" },
    tag   = "+file-browser",
})

hl.window_rule({
    name  = "file-browser-props",
    match = { tag = "file-browser" },
    float = true,
    size  = "(monitor_w*0.7) (monitor_h*0.7)",
})

-- Picture-in-Picture
hl.window_rule({
    name  = "tag-pip",
    match = { title = "^(Picture-in-Picture|Picture in picture)$" },
    tag   = "+picture-in-picture",
})

hl.window_rule({
    name             = "pip-props",
    match            = { tag = "picture-in-picture" },
    pin              = true,
    max_size         = "640 480",
    float            = true,
    opaque           = true,
    animation        = "gnomed",
    move             = "(monitor_w-window_w-10) (monitor_h-window_h-10)",
    keep_aspect_ratio = true,
})

-- Browser
hl.window_rule({
    name  = "tag-browser",
    match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" },
    tag   = "+browser",
})

hl.window_rule({
    name  = "tag-browser-chrome",
    match = { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" },
    tag   = "+browser",
})


---------------------
---- KEYBINDINGS ----
---------------------

-- https://wiki.hypr.land/Configuring/Basics/Binds/
-- https://wiki.hypr.land/Configuring/Basics/Dispatchers/

hl.bind("CTRL + grave", hl.dsp.workspace.toggle_special("Terminal"))

hl.bind("SUPER + A", hl.dsp.exec_cmd(MENU))
hl.bind("SUPER + T", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + P", hl.dsp.window.pseudo())

hl.bind("SUPER + F", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.resize({ exact = "60% 90%" }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + tab", hl.dsp.focus({ monitor = "+1" }))
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + tab", function()
    hl.dispatch(hl.dsp.window.alter_zorder("bottom"))
    hl.dispatch(hl.dsp.window.cycle_next())
end)

-- Switch workspaces with SUPER + [0-9]
for i = 1, 9 do
    hl.bind("SUPER + " .. i,           hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. i,   hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + 0",         hl.dsp.focus({ workspace = "name:Knuth" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "name:Knuth" }))

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
hl.bind("CTRL + Escape", hl.dsp.exec_cmd("killall waybar || hyprctl dispatch exec waybar"))

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


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("dunst")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
end)
