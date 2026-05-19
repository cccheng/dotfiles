
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

