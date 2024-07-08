return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup({})
            require("mini.align").setup({})
            require("mini.comment").setup({
                options = {
                    ignore_blank_line = true,
                },
            })
            require("mini.cursorword").setup({})
            require("mini.git").setup({})
            require("mini.hipatterns").setup({
                highlighters = {
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })
            require("mini.move").setup({})
            require("mini.notify").setup({
                window = {
                    winblend = 10,
                },
            })
            require("mini.trailspace").setup({})

            vim.api.nvim_set_hl(0, "MiniCursorword", { link = "VisualNOS" })
            vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "NormalFloat" })
        end
    },
    {
        "folke/flash.nvim",
        event = "BufReadPre",
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
        config = function()
            require("flash").setup({
                modes = {
                    search = {
                        enabled = false,
                    },
                },
            })
            vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#392313", bg = "#e4aa81", bold = true })
            vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#333913", bg = "#b9c289", bold = true })
            vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#1d1339", bg = "#a69acb", bold = true })
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = { "qf" },
        config = function()
            require("bqf").setup({
                auto_enable = true,
                auto_resize_height = true,
                preview = {
                    win_height = 24,
                    border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
                    show_title = false,
                    winblend = 10,
                }
            })
        end,
    },
}
