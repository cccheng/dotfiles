
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

