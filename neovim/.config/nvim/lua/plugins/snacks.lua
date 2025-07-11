return {
    "folke/snacks.nvim",
    lazy = false,
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
        scope = {
            enabled = true,
        },

        styles = {
            scratch = {
                width = 120,
                height = math.floor(vim.o.lines * 0.85),
                border = "none",
            },
        },
    },
    keys = {
        { "<LEADER><TAB>", function() Snacks.scratch({ ft = "markdown", file = vim.fn.stdpath("data") .. "/scratch.md" }) end, desc = "Todo List" },
    },
}
