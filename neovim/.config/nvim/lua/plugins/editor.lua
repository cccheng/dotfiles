return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        keys = {
            { "<LEADER>f", mode = {"n"}, function() require("mini.files").open() end, desc = "Open File browser" },
            { "<LEADER>F", mode = {"n"}, function() require("mini.files").close() end, desc = "Close File browser" },
        },
        config = function()
            require("mini.ai").setup({})
            require("mini.align").setup({})
            require("mini.comment").setup({})
            require("mini.cursorword").setup({})
            require("mini.files").setup({})
            require("mini.move").setup({})
            require("mini.notify").setup({})
            require("mini.trailspace").setup({})
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
    },
}
