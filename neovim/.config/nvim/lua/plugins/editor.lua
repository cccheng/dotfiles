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
                    start_jumping = "<LEADER>ss",
                },
            })
            require("mini.move").setup({})
            require("mini.notify").setup({
                window = {
                    winblend = 50,
                },
            })
            -- require("mini.pairs").setup({})
            require("mini.surround").setup({
                -- Module mappings. Use `""` (empty string) to disable one.
                mappings = {
                    add            = "<LEADER>sa", -- Add surrounding in Normal and Visual modes
                    delete         = "<LEADER>sd", -- Delete surrounding
                    find           = "<LEADER>sf", -- Find surrounding (to the right)
                    find_left      = "<LEADER>sF", -- Find surrounding (to the left)
                    highlight      = "<LEADER>sh", -- Highlight surrounding
                    replace        = "<LEADER>sr", -- Replace surrounding
                    update_n_lines = "<LEADER>sn", -- Update `n_lines`
                },
            })
            require("mini.trailspace").setup({})

            require("which-key").add({
                { "<LEADER>s", group = "Surrounding/Jump2d" },
            })
            vim.api.nvim_set_hl(0, "MiniJump", { reverse = true })
            vim.api.nvim_set_hl(0, "MiniJump2dSpot", { reverse = true })
            vim.api.nvim_set_hl(0, "MiniCursorword", { bold = true })
            vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bold = true })
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
                    -- border = "solid",
                    -- border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
                    show_title = false,
                    winblend = 10,
                }
            })
        end,
    },
}
