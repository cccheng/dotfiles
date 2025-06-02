return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        keys = {
            { "<LEADER>s", "", desc = "Surrounding/Jump" },
        },
        config = function()
            require("mini.ai").setup({})
            require("mini.align").setup({})
            require("mini.comment").setup({})
            require("mini.cursorword").setup({})
            require("mini.diff").setup({
                -- Disabled by default
                source = require("mini.diff").gen_source.none(),
            })
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
            -- require("mini.map").setup({
            --     symbols = {
            --         -- encode = require("mini.map").gen_encode_symbols.block("3x2"),
            --         encode = require("mini.map").gen_encode_symbols.dot("4x2"),
            --         -- encode = require("mini.map").gen_encode_symbols.shade("2x1"),
            --     },
            --     integrations = {
            --         require("mini.map").gen_integration.builtin_search(),
            --         require("mini.map").gen_integration.diff(),
            --         require("mini.map").gen_integration.diagnostic(),
            --         require("mini.map").gen_integration.gitsigns(),
            --     },
            --     window = {
            --         winblend = 10,
            --         zindex = 100,
            --     },
            -- })
            require("mini.move").setup({})
            require("mini.notify").setup({
                window = {
                    winblend = 50,
                },
            })
            -- require("mini.pairs").setup({})
            require("mini.snippets").setup({
                snippets = {
                    -- Load custom file with global snippets first (adjust for Windows)
                    require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/global.json"),

                    require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/local.json"),

                    -- Load snippets based on current language by reading files from
                    -- "snippets/" subdirectories from 'runtimepath' directories.
                    require("mini.snippets").gen_loader.from_lang(),
                },
                mappings = {
                    -- Expand snippet at cursor position. Created globally in Insert mode.
                    expand = "<C-s>",
                },
            })
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

            vim.api.nvim_set_hl(0, "MiniJump", { bold = true, underline = true })
            vim.api.nvim_set_hl(0, "MiniJump2dSpot", { bold = true, underline = true })
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
