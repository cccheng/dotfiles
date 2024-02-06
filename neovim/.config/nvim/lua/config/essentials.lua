
vim.g.autoformat = true

local opt = vim.opt

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.cursorline = true -- Enable highlighting of the current line
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.pumblend = 10 -- Popup blend
opt.pumheight = 30 -- Maximum number of entries in a popup

opt.showmode = false -- Dont show mode since we have a statusline
opt.number = true -- Print line number
opt.relativenumber = false -- Relative line numbers
opt.backspace = {"indent", "eol", "start"}
opt.scrolloff = 4 -- Lines of context
opt.winminwidth = 5 -- Minimum window width

-- opt.wildmenu = true
-- opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.completeopt = {"menu", "menuone", "noselect"}

opt.tabstop = 8 -- Number of spaces tabs count for
opt.shiftwidth = 4 -- Size of an indent
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = true -- Round indent
opt.autoindent = true
opt.smartindent = true -- Insert indents automatically

opt.smartcase = true -- Don't ignore case with capitals
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true

opt.autoread = true
opt.title = true
opt.swapfile = false
opt.backup = false
opt.spelllang = { "en" }
opt.termguicolors = true -- True color support
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.mouse = "" -- Disable mouse mode
opt.wrap = true -- Enable line wrap
opt.splitright = true -- Put new windows right of current
opt.splitbelow = true -- Put new windows below current
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    -- fold = "⸱",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
    opt.smoothscroll = true
end

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- tabs
vim.keymap.set("n", "<c-h>", "<CMD>:tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<c-l>", "<CMD>:tabnext<CR>", { desc = "Next tab" })

-- buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

