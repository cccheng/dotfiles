return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        config = function()
            require("ibl").setup({})
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('lualine').setup()
        end
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            require("scrollbar").setup({
                handle = {
                    blend = 17,
                    hide_if_all_visible = true, -- Hides everything if all lines are visible
                },
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = true, -- Requires gitsigns
                    handle = true,
                    search = false, -- Requires hlslens
                    ale = false, -- Requires ALE
                },
            })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                cmdline = {
                    enabled = true, -- enables the Noice cmdline UI
                    view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
                },
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
                views = {
                    hover = {
                        border = {
                            style = "rounded",
                        },
                        win_options = {
                            winblend = 17,
                        },
                    },
                },
                messages = {
                    view_search = false,
                },
            })

            vim.keymap.set("n", "<leader>tn", "<cmd>NoiceTelescope<cr>", { desc = "Noice" })
        end
    },
    -- {
    --     "anuvyklack/windows.nvim",
    --     dependencies = {
    --         "anuvyklack/middleclass",
    --         "anuvyklack/animation.nvim"
    --     },
    --     config = function()
    --         vim.o.winwidth = 10
    --         vim.o.winminwidth = 10
    --         vim.o.equalalways = false
    --         require('windows').setup()
    --     end
    -- },
}
