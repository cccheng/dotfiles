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
        { "<LEADER>t", "", desc = "Telescope/Picker" },
        -- grep
        { "<LEADER>tg", function() Snacks.picker.grep() end, desc = "Live grep" },
        { "<LEADER>tw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<LEADER>tW", function() Snacks.picker.grep_word({ args = {} }) end, desc = "Matched word", mode = { "n", "x" } },
        -- search
        { "<LEADER>ta", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<LEADER>tb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<LEADER>th", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<LEADER>tH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<LEADER>ti", function() Snacks.picker.icons({ layout = { preset = "ivy" } }) end, desc = "Icons" },
        { "<LEADER>tk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<LEADER>td", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<LEADER>tj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<LEADER>tq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<LEADER>tt", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        { "<LEADER>tm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<LEADER>tM", function() Snacks.picker.man() end, desc = "Man Pages" },
    },
}
