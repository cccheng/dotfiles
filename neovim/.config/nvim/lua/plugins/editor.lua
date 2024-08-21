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
            -- require("mini.git").setup({})
            require("mini.hipatterns").setup({
                highlighters = {
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })
            require("mini.jump").setup({})
            require("mini.jump2d").setup({
                view = {
                    dim = true,
                },
                mappings = {
                    start_jumping = "s",
                },
            })
            require("mini.move").setup({})
            require("mini.notify").setup({
                window = {
                    winblend = 30,
                },
            })
            require("mini.pairs").setup({})
            require("mini.trailspace").setup({})

            vim.api.nvim_set_hl(0, "MiniJump", { reverse = true })
            vim.api.nvim_set_hl(0, 'MiniJump2dSpot', { reverse = true })
            vim.api.nvim_set_hl(0, "MiniCursorword", { link = "VisualNOS" })
            vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "NormalFloat" })
        end
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
                    border = "solid",
                    -- border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
                    show_title = false,
                    winblend = 10,
                }
            })
        end,
    },
}
