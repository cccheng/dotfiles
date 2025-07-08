return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-symbols.nvim",
        },
        keys = {
            { "<LEADER>t", "", desc = "Telescope" },
        },
        config = function()
            local telescope = require("telescope.builtin")

            vim.keymap.set("n", "<LEADER>ts", telescope.find_files,  { desc = "Search files" })
            vim.keymap.set("n", "<LEADER>tg", telescope.live_grep,   { desc = "Live grep" })
            vim.keymap.set("n", "<LEADER>tf", telescope.grep_string, { desc = "Find current string" })
            vim.keymap.set("n", "<LEADER>tF", function() telescope.grep_string({word_match = "-w"}) end, { desc = "Find current word matched string" })
            vim.keymap.set("n", "<LEADER>tb", telescope.buffers,     { desc = "Buffers" })
            vim.keymap.set("n", "<LEADER>th", telescope.help_tags,   { desc = "Help tags" })
            vim.keymap.set("n", "<LEADER>tk", telescope.keymaps,     { desc = "Show keymaps" })
            vim.keymap.set("n", "<LEADER>td", "<CMD>Telescope diagnostics<CR>", { desc = "Diagnostics" })
            vim.keymap.set("n", "<LEADER>tm", "<CMD>Telescope man_pages<CR>", { desc = "Man pages" })
            vim.keymap.set("n", "<LEADER>f",  "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File browser" })
            vim.keymap.set("n", "<LEADER>tj", "<CMD>Telescope jumplist<CR>", { desc = "Jump list" })
            vim.keymap.set("n", "<LEADER>tt", "<CMD>Telescope colorscheme enable_preview=true<CR>", { desc = "colorscheme" })

            vim.keymap.set("n", "<LEADER>gs", "<CMD>Telescope git_status<CR>", { desc = "Git status" })
            vim.keymap.set("n", "<LEADER>gB", "<CMD>Telescope git_bcommits<CR>", { desc = "Git commits of current buffer" })

            vim.keymap.set("n", "<LEADER>tSe", function() telescope.symbols({ sources = {"emoji"} }) end, { desc = "Telescope emoji symbols" })
            vim.keymap.set("n", "<LEADER>tSg", function() telescope.symbols({ sources = {"gitmoji"} }) end, { desc = "Telescope gitmoji symbols" })
            vim.keymap.set("n", "<LEADER>tSk", function() telescope.symbols({ sources = {"kaomoji"} }) end, { desc = "Telescope kaomoji symbols" })
            vim.keymap.set("n", "<LEADER>tSl", function() telescope.symbols({ sources = {"latex"} }) end, { desc = "Telescope latex symbols" })
            vim.keymap.set("n", "<LEADER>tSm", function() telescope.symbols({ sources = {"math"} }) end, { desc = "Telescope math symbols" })
            vim.keymap.set("n", "<LEADER>tSn", function() telescope.symbols({ sources = {"nerd"} }) end, { desc = "Telescope nerd symbols" })

            require("telescope").setup({
                defaults = require("telescope.themes").get_ivy {
                    winblend = 10,
                    prompt_prefix = "   ",
                    selection_caret = "▶ ",
                    -- borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
                    mappings = {
                        ["n"] = {
                            ["<ESC>"] = "close",
                            ["<C-w>"] = "close",
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                        ["i"] = {
                            ["<ESC>"] = "close",
                            ["<C-w>"] = "close",
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                },
                extensions = {
                    ["fzf"] = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    ["file_browser"] = {
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["n"] = {
                                ["<ESC>"] = "close",
                                ["<C-w>"] = "close",
                                ["<C-j>"] = "move_selection_next",
                                ["<C-k>"] = "move_selection_previous",
                            },
                            ["i"] = {
                                ["<ESC>"] = "close",
                                ["<C-w>"] = "close",
                                ["<C-j>"] = "move_selection_next",
                                ["<C-k>"] = "move_selection_previous",
                            },
                        },
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_ivy({
                            winblend = 10,
                        })
                    }
                }
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("file_browser")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make"
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
    }
}
