-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<DOWN>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<UP>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- focus scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- focus highlight searches
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- tabs
vim.keymap.set("n", "<C-h>", "<CMD>:tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-l>", "<CMD>:tabnext<CR>", { desc = "Next tab" })

-- buffers
vim.keymap.set("n", "[b", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- quickfix
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- clear search with <ESC>
vim.keymap.set({ "i", "n" }, "<ESC><ESC>", "<CMD>noh<CR><ESC>", { desc = "Escape and clear hlsearch" })

-- better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- case change in visual mode
vim.keymap.set("v", "`", "u", { silent = true })
vim.keymap.set("v", "<A-`>", "U", { silent = true })

