-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<DOWN>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<UP>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true, silent = true })

-- tabs
vim.keymap.set("n", "<C-h>", "<CMD>:tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-l>", "<CMD>:tabnext<CR>", { desc = "Next tab" })

-- buffers
vim.keymap.set("n", "[b", "<CMD>bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<ESC>", "<CMD>noh<CR><ESC>", { desc = "Escape and clear hlsearch" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

