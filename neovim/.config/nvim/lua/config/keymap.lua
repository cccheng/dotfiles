-- https://www.reddit.com/r/neovim/comments/1fxpoke/for_those_who_likes_a_tidy_config/
--
-- 1.4 LISTING MAPPINGS                                     *map-listing*
--
--   CHAR       MODE
--   ""         Normal, Visual, Select and Operator-pending
--   n          Normal
--   v          Visual and Select
--   s          Select
--   x          Visual
--   o          Operator-pending
--   !          Insert and Command-line
--   i          Insert
--   l          ":lmap" mappings for Insert, Command-line and Lang-Arg
--   c          Command-line
--   t          Terminal-Job

local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<DOWN>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<UP>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("n", "<LEADER>tc",
    function()
        vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
        vim.o.number = not vim.o.number
        vim.o.relativenumber = not vim.o.relativenumber
        require("ibl").update({ enabled = not require("ibl.config").get_config(-1).enabled })
        require("scrollbar.utils").toggle()
    end,
    { desc = "Toggle sign and number columns" })

-- focus scrolling
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- search for word under cursor without moving the cursor
map("n", "*", "*``", { noremap = true, silent = true })
map("n", "#", "#``", { noremap = true, silent = true })

-- tabs
map("n", "<C-h>", "<CMD>:tabprev<CR>", { desc = "Previous tab" })
map("n", "<C-l>", "<CMD>:tabnext<CR>", { desc = "Next tab" })

-- buffers
map("n", "[b", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- quickfix
map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- clear search with <ESC>
map({ "i", "n" }, "<ESC>", "<CMD>noh<CR><ESC>", { desc = "Escape and clear hlsearch" })

-- better indenting in visual mode
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

-- case change in visual mode
map("v", "`", "u", { silent = true })
map("v", "<A-`>", "U", { silent = true })

