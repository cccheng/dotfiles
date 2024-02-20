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

            require("which-key").register({ ["<leader>t"] = { name = "+Telescope" } })
            vim.keymap.set("n", "<leader>ts", telescope.find_files, { desc = "Search files" })
            vim.keymap.set("n", "<leader>tg", telescope.live_grep,  { desc = "Live grep" })
            vim.keymap.set("n", "<leader>tb", telescope.buffers,    { desc = "Buffers" })
            vim.keymap.set("n", "<leader>th", telescope.help_tags,  { desc = "Help tags" })
            vim.keymap.set("n", "<leader>tk", telescope.keymaps,    { desc = "Show keymaps" })
            -- open file_browser with the path of the current buffer
            vim.keymap.set("n", "<leader>tf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "File browser" })
            vim.keymap.set("n", "<leader>tF", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })

            require("telescope").setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            height = 0.9,
                            width = 0.95,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        theme = "ivy",
                        winblend = 17,
                    },
                    live_grep = {
                        theme = "ivy",
                        winblend = 17,
                    },
                    buffers = {
                        theme = "ivy",
                        winblend = 17,
                    },
                    help_tags = {
                        theme = "ivy",
                        winblend = 17,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            })

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
                        require("telescope.themes").get_dropdown({
                            winblend = 17,
                        })
                    }
                }
            })

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
                        winblend = 17,
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                    },
                },
            })

            require("telescope").load_extension("file_browser")
        end
    }
}
