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
map({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({"n", "x"}, "<DOWN>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({"n", "x"}, "<UP>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("n", "<LEADER>tc",
    function()
        vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
        vim.o.number = not vim.o.number
        vim.o.relativenumber = not vim.o.relativenumber
        if vim.g.snacks_indent == nil or vim.g.snacks_indent == true then
            vim.g.snacks_indent = false
        else
            vim.g.snacks_indent = true
        end
        require("scrollbar.utils").toggle()
    end,
    { desc = "Toggle sign and number columns" })

-- focus scrolling
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- search for word under cursor without moving the cursor
map("n", "*", "*``", { noremap = true, silent = true })
map("n", "#", "#``", { noremap = true, silent = true })

-- g/ search for word under cursor
map("n", "g/", "*") -- `:h *`

-- [/ search for first occurrence of the current word
map("n", "[/", "[<c-i>") -- `:h [_ctrl-i`

-- / search inside selection (visual mode)
map("x", "/", "<esc>/\\%V") -- `:h /\%V`

-- tabs
map("n", "<C-h>", "<CMD>:tabprev<CR>", { desc = "Previous tab" })
map("n", "<C-l>", "<CMD>:tabnext<CR>", { desc = "Next tab" })

-- buffers
map("n", "[b", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- quickfix
map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- clear search and stop snippet on escape with <ESC>
map({ "i", "n", "s" }, "<ESC>", function()
    vim.cmd("noh")
    if vim.snippet then
        vim.snippet.stop()
    end
    return "<ESC>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- move in insert mode, and command-line mode
map({"i", "c"}, "<C-j>", "<Down>", { desc = "Move Down in insert mode" })
map({"i", "c"}, "<C-k>", "<Up>", { desc = "Move Up in insert mode" })
map({"i", "c"}, "<C-h>", "<Left>", { desc = "Move Left in insert mode" })
map({"i", "c"}, "<C-l>", "<Right>", { desc = "Move Right in insert mode" })

-- resize window using <CTRL> arrow keys
map("n", "<C-Up>", "<CMD>resize +2<CR>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<CMD>resize -2<CR>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase Window Width" })

-- better indenting in visual mode
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

-- case change in visual mode
map("v", "`", "u", { silent = true })
map("v", "<A-`>", "U", { silent = true })

-- quit
map("n", "<LEADER>q", "", { desc = "Quit" })
map("n", "<LEADER>qq", "<CMD>quit<CR>", { desc = "Quit All" })
map("n", "<LEADER>qa", "<CMD>quitall<CR>", { desc = "Quit All" })

