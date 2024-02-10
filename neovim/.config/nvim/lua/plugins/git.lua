return {
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
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
                    require("which-key").register({ ["<leader>h"] = { name = "+Hunk" } })
                    require("which-key").register({ ["<leader>ht"] = { name = "+Toggle" } })
                    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
                    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("v", "<leader>hs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Stage hunk" })
                    map("v", "<leader>hr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Reset hunk" })
                    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
                    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
                    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<leader>hb", function() gs.blame_line{full=true} end, { desc = "Blame current line" })
                    map("n", "<leader>hd", gs.diffthis, { desc = "Diff" })
                    map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff ~" })
                    map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
                    map("n", "<leader>htd", gs.toggle_deleted, { desc = "Tottle deleted" })

                    -- Text object
                    map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end
            })
        end
    }
}
