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
                        -- pattern = { "󰫃", "󰫄", "󰫅", "󰫆", "󰫇", "󰫈", },
                        pattern = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
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
        "kevinhwang91/nvim-bqf",
        ft = { "qf" },
        config = function()
            require("bqf").setup({
                auto_enable = true,
                auto_resize_height = true,
                preview = {
                    win_height = 24,
                    border = "solid",
                    show_title = false,
                    winblend = 20,
                }
            })
        end,
    },
}
