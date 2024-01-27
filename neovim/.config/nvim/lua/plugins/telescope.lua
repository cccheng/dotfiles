return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            local telescope = require("telescope.builtin")

            vim.keymap.set("n", "<leader>tf", telescope.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>tF", require("telescope").extensions.file_browser.file_browser, { desc = "File browser" })
            vim.keymap.set("n", "<leader>tg", telescope.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>tb", telescope.buffers, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>th", telescope.help_tags, { desc = "Help tags" })

            require("telescope").setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }

            require('telescope').load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        event = "VeryLazy",
        build = "make"
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }

                        -- pseudo code / specification for writing custom displays, like the one
                        -- for "codeactions"
                        -- specific_opts = {
                        --   [kind] = {
                        --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                        --     make_display = function(displayer) -> function(e)
                        --     make_ordinal = function(e) -> string
                        --   },
                        --   -- for example to disable the custom builtin "codeactions" display
                        --      do the following
                        --   codeactions = false,
                        -- }
                    }
                }
            })
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                    },
                },
            })

            require("telescope").load_extension("file_browser")
        end
    }
}
