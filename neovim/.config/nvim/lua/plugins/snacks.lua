return {
    "folke/snacks.nvim",
    opts = {
        bigfile = {
            enabled = true,
        },
        indent = {
            enabled = true,
            animate = {
                style = "out",
                easing = "linear",
                duration = {
                    step = 20, -- ms per step
                    total = 250, -- maximum duration
                },
            },
        },
    },
}
