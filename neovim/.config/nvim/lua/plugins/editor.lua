return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.align").setup({
            })

            require("mini.notify").setup({
            })

            require("mini.comment").setup({
            })

            require("mini.cursorword").setup({
            })

            require("mini.trailspace").setup({
            })

            require("mini.tabline").setup({
                set_vim_settings = false,
                tabpage_section = "none",
            })
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
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
            },
            highlight = {
                groups = {
                    match = "SpecialKey",
                    current = "Search",
                    label = "Special"
                },
            },
        },
    },
}
