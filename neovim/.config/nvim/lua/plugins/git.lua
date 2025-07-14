return {
    {
        "sindrets/diffview.nvim",
        lazy = true,
        keys = {
            { "<LEADER>g", "", desc = "Git" },
            {
                "<LEADER>gd",
                mode = {"n"},
                function()
                    if next(require("diffview.lib").views) == nil then
                        vim.cmd("DiffviewOpen")
                    else
                        vim.cmd("DiffviewClose")
                    end
                end,
                desc = "Git diff view"
            },
            { "<LEADER>gh", mode = {"n"}, "<CMD>DiffviewFileHistory %<CR>", desc = "Git history for the current file" },
            { "<LEADER>gH", mode = {"n"}, "<CMD>DiffviewFileHistory<CR>", desc = "Git history for the current branch" },
        },
        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
                view = {
                    default = {
                        layout = "diff2_horizontal",
                        disable_diagnostics = true,
                        winbar_info = true,
                    },
                },
                file_panel = {
                    listing_style = "list",
                    win_config = {
                        type = "split",
                        position = "bottom",
                        height = 5,
                    },
                },
            })
        end
    },
    {
        "FabijanZulj/blame.nvim",
        lazy = true,
        keys = {
            { "<LEADER>gb", mode = {"n"}, "<CMD>BlameToggle window<CR>", desc = "Git blame" },
        },
        config = function()
            require("blame").setup({
                date_format = "%Y.%m.%d",
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
        keys = {
            { "<LEADER>h", "", desc = "Hunk" },
            { "<LEADER>ht", "", desc = "Toggle" },
        },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "+" },
                    change       = { text = "│" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                diff_opts = {
                    algorithm = "histogram",
                },
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
                    end, { expr = true, desc = "Next hunk" })

                    map("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Prev hunk" })

                    -- Actions
                    map("n", "<LEADER>hs", gs.stage_hunk, { desc = "Stage hunk" })
                    map("n", "<LEADER>hr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("v", "<LEADER>hs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Stage hunk" })
                    map("v", "<LEADER>hr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Reset hunk" })
                    map("n", "<LEADER>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map("n", "<LEADER>hp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<LEADER>hb", function() gs.blame_line {full=true} end, { desc = "Blame current line" })
                    map("n", "<LEADER>hd", function()
                        if vim.wo.diff then
                            vim.cmd("diffoff")
                            vim.cmd("only")
                        else
                            gs.diffthis()
                        end
                    end, { desc = "Diff" })
                    map("n", "<LEADER>htb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
                    map("n", "<LEADER>htd", gs.toggle_deleted, { desc = "Toggle show deleted" })
                    map("n", "<LEADER>htl", gs.toggle_linehl, { desc = "Toggle line highlight" })
                    map("n", "<LEADER>htw", gs.toggle_word_diff, { desc = "Toggle word diff" })

                    -- Text object
                    map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end
            })
        end
    }
}
