return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
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
            filter = function(buf)
                local no_indent_fts = {
                    "gitcommit",
                }
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    and not vim.tbl_contains(no_indent_fts, vim.bo[buf].filetype)
            end,
        },
        picker = {
            layout = {
                preset = "ivy",
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
