return {
    {
        "lewis6991/gitsigns.nvim",
        cmd = "Gitsigns",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
        dependencies = {
            "folke/snacks.nvim",
        },
        keys = {
            { "<LEADER>g", "", desc = "Git" },
            { "<LEADER>h", "", desc = "Hunk" },
            { "<LEADER>tg", "", desc = "Toggle Git" },
        },
        opts = {
            signs = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_', show_count = true },
                topdelete    = { text = '‾', show_count = true  },
                changedelete = { text = '~', show_count = true  },
                untracked    = { text = '┆' },
            },
            signs_staged = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_', show_count = true  },
                topdelete    = { text = '‾', show_count = true  },
                changedelete = { text = '~', show_count = true  },
            },
            count_chars = {
                [1] = "₁", [2] = "₂", [3] = "₃", [4] = "₄", [5] = "₅",
                [6] = "₆", [7] = "󰭀", [8] = "󰭁", [9] = "󰭂", ["+"] = "₊"
            },
            signcolumn         = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl              = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl             = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff          = false, -- Toggle with `:Gitsigns toggle_word_diff`
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                delay = 200,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            diff_opts = {
                algorithm = "histogram",
            },
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.nav_hunk("prev") end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Prev unstaged hunk" })
                    map("n", "]c", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.nav_hunk("next") end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Next unstaged hunk" })

                    -- Previous/next unstaged/staged hunks
                    map("n", "[h", function() gs.nav_hunk("prev") end, { desc = "Prev hunk" })
                    map("n", "]h", function() gs.nav_hunk("next") end, { desc = "Next hunk" })

                    -- Actions
                    map("n", "<LEADER>hs", gs.stage_hunk, { desc = "Stage hunk" })
                    map("n", "<LEADER>hr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("v", "<LEADER>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Stage hunk" })
                    map("v", "<LEADER>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Reset hunk" })
                    map("n", "<LEADER>hp", gs.preview_hunk_inline, { desc = "Inline preview hunk" })
                    map("n", "<LEADER>hP", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<LEADER>hq", gs.setqflist, { desc = "Set qflist" })
                    map('n', '<LEADER>hQ', function() gs.setqflist("all") end)
                    map("n", "<LEADER>gb", function() gs.blame_line { full = true } end, { desc = "Blame current line" })
                    map("n", "<LEADER>gB", function() gs.blame() end, { desc = "Blame buffer" })
                    map("n", "<LEADER>gd", function()
                        if vim.wo.diff then
                            vim.cmd("diffoff")
                            vim.cmd("only")
                        else
                            gs.diffthis()
                        end
                    end, { desc = "Diff" })
                    map("n", "<LEADER>gD", function()
                        if vim.wo.diff then
                            vim.cmd("diffoff")
                            vim.cmd("only")
                        else
                            gs.diffthis("~")
                        end
                    end, { desc = "Diff (cached)" })

                    Snacks.toggle({
                        name = "Git Signs",
                        get = function()
                            return require("gitsigns.config").config.signcolumn
                        end,
                        set = function(state)
                            require("gitsigns").toggle_signs(state)
                        end,
                    }):map("<LEADER>tgs")

                    Snacks.toggle({
                        name = "Current Line Blame",
                        get = function()
                            return require("gitsigns.config").config.current_line_blame
                        end,
                        set = function(state)
                            require("gitsigns").toggle_current_line_blame(state)
                        end,
                    }):map("<LEADER>tgb")

                    Snacks.toggle({
                        name = "Number Highlight",
                        get = function()
                            return require("gitsigns.config").config.numhl
                        end,
                        set = function(state)
                            require("gitsigns").toggle_numhl(state)
                        end,
                    }):map("<LEADER>tgn")

                    Snacks.toggle({
                        name = "Line Highlight",
                        get = function()
                            return require("gitsigns.config").config.linehl
                        end,
                        set = function(state)
                            require("gitsigns").toggle_linehl(state)
                        end,
                    }):map("<LEADER>tgl")

                    Snacks.toggle({
                        name = "Word Diff",
                        get = function()
                            return require("gitsigns.config").config.word_diff
                        end,
                        set = function(state)
                            require("gitsigns").toggle_word_diff(state)
                        end,
                    }):map("<LEADER>tgw")

                    -- Text object
                    map({"o", "x"}, "ih", gs.select_hunk)
                end
            })
        end
    }
}
