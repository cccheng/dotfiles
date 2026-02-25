return {
    {
        "FabijanZulj/blame.nvim",
        lazy = true,
        keys = {
            { "<LEADER>gb", mode = {"n"}, "<CMD>BlameToggle window<CR>", desc = "Git Blame" },
        },
        config = function()
            require("blame").setup({
                date_format = "%Y.%m.%d",
            })
        end,
    },
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
                add          = { text = "" },
                change       = { text = "" },
                delete       = { text = "" },
                topdelete    = { text = "‾" },
                changedelete = { text = "󱕖" },
                untracked    = { text = "┆" },
            },
            signs_staged = {
                add          = { text = "┃" },
                change       = { text = "┃" },
                delete       = { text = "" },
                topdelete    = { text = "" },
                changedelete = { text = "┃" },
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
                    map("n", "]c", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Next unstaged hunk" })

                    map("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Prev unstaged hunk" })

                    -- Previous/next unstaged/staged hunks
                    map("n", "[h", function()
                        gs.nav_hunk("prev", {target = "all"})
                    end, { desc = "Prev hunk" })

                    map("n", "]h", function()
                        gs.nav_hunk("next", {target = "all"})
                    end, { desc = "Next hunk" })

                    -- Previous/next staged hunks
                    map("n", "[H", function()
                        gs.nav_hunk("prev", {target = "all"})
                    end, { desc = "Prev staged hunk" })

                    map("n", "]H", function()
                        gs.nav_hunk("next", {target = "all"})
                    end, { desc = "Next staged hunk" })

                    -- Actions
                    map("n", "<LEADER>hs", gs.stage_hunk, { desc = "Stage hunk" })
                    map("n", "<LEADER>hr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("v", "<LEADER>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Stage hunk" })
                    map("v", "<LEADER>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Reset hunk" })
                    map("n", "<LEADER>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map("n", "<LEADER>hp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<LEADER>hb", function() gs.blame_line { full = true } end, { desc = "Blame current line" })
                    map("n", "<LEADER>hq", gs.setqflist, { desc = "Set qflist" })
                    map('n', '<LEADER>hQ', function() gs.setqflist("all") end)
                    map("n", "<LEADER>gd", function()
                        if vim.wo.diff then
                            vim.cmd("diffoff")
                            vim.cmd("only")
                        else
                            gs.diffthis()
                        end
                    end, { desc = "Diff" })

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
                        name = "Show Deleted",
                        get = function()
                            return require("gitsigns.config").config.show_deleted
                        end,
                        set = function(state)
                            require("gitsigns").toggle_deleted(state)
                        end,
                    }):map("<LEADER>tgd")

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
