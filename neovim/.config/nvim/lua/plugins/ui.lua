return {
    {
        "m4xshen/smartcolumn.nvim",
        event = {
            "BufNewFile",
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
                "mcphub",
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
            "BufNewFile",
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
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            progress = {
                display = {
                    progress_icon = {
                        pattern = { "󰫃", "󰫄", "󰫅", "󰫆", "󰫇", "󰫈", },
                    },
                },
            },
        },
    },
    {
        "miversen33/sunglasses.nvim",
        event = "UIEnter",
        config = function()
            require("sunglasses").setup({
                filter_type = "SHADE",
                filter_percent = .20,
            })
        end
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = { "WinLeave" },
        config = function()
            require("colorful-winsep").setup({
                -- choose between "single", "rounded", "bold" and "double".
                -- Or pass a table like this: { "─", "│", "┌", "┐", "└", "┘" },
                border = "rounded",
            })
        end
    },
}
