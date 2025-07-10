return {
    {
        "m4xshen/smartcolumn.nvim",
        event = {
            "BufEnter",
            "BufReadPre",
        },
        opts = {
            colorcolumn = {"100"},
            custom_colorcolumn = {
                gitcommit = "72",
            },
            disabled_filetypes = {
                "qf",
                "netrw",
                "lazy",
                "mason",
                "help",
                "text",
                "markdown",
                "tex",
                "html",
                "DiffviewFileHistory",
                "codecompanion",
            },
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {
                        "branch", "diff", "diagnostics",
                        {
                            require("noice").api.statusline.mode.get,
                            cond = require("noice").api.statusline.mode.has,
                            color = { fg = vim.fn.synIDattr(vim.fn.hlID("MoreMsg"), "fg") },
                        },
                    },
                    lualine_c = {
                        {
                            function() return vim.fn.getcwd() end,
                            padding = { right = 0 },
                            separator = "⫽",
                        },
                        {
                            "filename",
                            newfile_status = true,
                            path = 1,
                            padding = { left = 0 },
                        },
                    },
                    lualine_x = {
                        {
                            require("plugins.codecompanion.lualine"),
                            color = { fg = vim.fn.synIDattr(vim.fn.hlID("MoreMsg"), "fg") },
                        },
                        {
                            "encoding",
                            show_bomb = true,
                        },
                        "fileformat",
                        {
                            "filetype",
                            colored = false,
                        },
                    },
                    lualine_y = {"searchcount", "progress"},
                    lualine_z = {"selectioncount",
                        {
                            function()
                                return string.format("%2d:%d/%d", vim.fn.virtcol("."), vim.fn.line("."), vim.fn.line("$"))
                            end,
                        }
                    },
                },
                extensions = {
                    "lazy", "mason", "man", "quickfix", "toggleterm", "symbols-outline",
                },
            })
        end
    },
    {
        "petertriho/nvim-scrollbar",
        event = {
            "BufEnter",
            "BufReadPre",
        },
        config = function()
            require("scrollbar").setup({
                handle = {
                    blend = 10,
                    hide_if_all_visible = true, -- Hides everything if all lines are visible
                },
                handlers = {
                    cursor = true,
                    diagnostic = false,
                    gitsigns = true , -- Requires gitsigns
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
        keys = {
            { "<LEADER>tn", mode = {"n"}, "<CMD>NoiceTelescope<CR>",  desc = "Noice" },
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
                            winblend = 10,
                        },
                    },
                },
                messages = {
                    view_search = false,
                },
                routes = {
                    {
                        view = "notify",
                        filter = { event = "msg_showmode" },
                    },
                },
            })
        end
    },
    {
        "miversen33/sunglasses.nvim",
        event = "UIEnter",
        config = function()
            require("sunglasses").setup({
                filter_type = "SHADE",
                filter_percent = .25,
            })
        end
    },
}
