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
            { "<LEADER>ts", function() require("telescope.builtin").find_files() end, desc = "Search files" },
            { "<LEADER>tg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
            { "<LEADER>tf", function() require("telescope.builtin").grep_string() end, desc = "Find current string" },
            { "<LEADER>tF", function() require("telescope.builtin").grep_string({word_match = "-w"}) end, desc = "Find current word matched string" },
            { "<LEADER>tb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
            { "<LEADER>th", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
            { "<LEADER>tk", function() require("telescope.builtin").keymaps() end, desc = "Show keymaps" },
            { "<LEADER>td", "<CMD>Telescope diagnostics<CR>", desc = "Diagnostics" },
            { "<LEADER>tm", "<CMD>Telescope man_pages<CR>", desc = "Man pages" },
            { "<LEADER>f",  "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File browser" },
            { "<LEADER>tj", "<CMD>Telescope jumplist<CR>", desc = "Jump list" },
            { "<LEADER>tt", "<CMD>Telescope colorscheme enable_preview=true<CR>", desc = "colorscheme" },
            { "<LEADER>gs", "<CMD>Telescope git_status<CR>", desc = "Git status" },
            { "<LEADER>gB", "<CMD>Telescope git_bcommits<CR>", desc = "Git commits of current buffer" },
            { "<LEADER>tSe", function() require("telescope.builtin").symbols({ sources = {"emoji"} }) end, desc = "Telescope emoji symbols" },
            { "<LEADER>tSg", function() require("telescope.builtin").symbols({ sources = {"gitmoji"} }) end, desc = "Telescope gitmoji symbols" },
            { "<LEADER>tSk", function() require("telescope.builtin").symbols({ sources = {"kaomoji"} }) end, desc = "Telescope kaomoji symbols" },
            { "<LEADER>tSl", function() require("telescope.builtin").symbols({ sources = {"latex"} }) end, desc = "Telescope latex symbols" },
            { "<LEADER>tSm", function() require("telescope.builtin").symbols({ sources = {"math"} }) end, desc = "Telescope math symbols" },
            { "<LEADER>tSn", function() require("telescope.builtin").symbols({ sources = {"nerd"} }) end, desc = "Telescope nerd symbols" },
        },
        config = function()
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
