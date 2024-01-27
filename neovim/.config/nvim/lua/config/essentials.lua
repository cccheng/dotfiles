
vim.opt.showmode = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.backspace = {"indent", "eol", "start"}

vim.opt.wildmenu = true
vim.opt.completeopt = {"menuone", "noselect"}

vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.autoread = true
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50
vim.opt.mouse = ""
vim.opt.exrc = true
vim.opt.wrap = false
vim.opt.splitright = true

vim.keymap.set("n", "<C-H>", "<CMD>:tabprev<CR>")
vim.keymap.set("n", "<C-L>", "<CMD>:tabnext<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

