--           ██
--          ░░
--  ██    ██ ██ ██████████  ██████  █████
-- ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
-- ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
--  ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
--   ░░██   ░██ ███ ░██ ░██░███   ░░█████
--    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
--

vim.g.autoformat = true

local opt = vim.opt

opt.ttyfast = true              -- Fast terminal connection
opt.updatetime = 50             -- Faster CursorHold events (default 4000ms)
opt.timeoutlen = 300            -- Faster key sequence timeout
opt.ttimeoutlen = 10            -- Faster key code timeout
opt.redrawtime = 1500           -- Time limit for syntax highlighting
opt.synmaxcol = 200             -- Limit syntax highlighting to 200 columns

opt.clipboard = "unnamedplus"   -- Sync with system clipboard
opt.cursorline = true           -- Enable highlighting of the current line
opt.formatoptions = "jcroqlnt"  -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit"      -- preview incremental substitute
opt.laststatus = 3              -- global statusline
opt.pumblend = 10               -- Popup blend
opt.pumheight = 30              -- Maximum number of entries in a popup

opt.showmode = false            -- Dont show mode since we have a statusline
opt.number = true               -- Print line number
opt.relativenumber = true       -- Relative line numbers
opt.backspace = {"indent", "eol", "start"}
opt.scrolloff = 4               -- Lines of context
opt.smoothscroll = true
opt.winminwidth = 5             -- Minimum window width

-- opt.wildmenu = true
-- opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
opt.completeopt = {"menu", "menuone", "noinsert", "noselect"}

opt.modeline = true

opt.tabstop = 8                 -- Number of spaces tabs count for
opt.shiftwidth = 4              -- Size of an indent
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = true           -- Round indent
opt.autoindent = true
opt.smartindent = true          -- Insert indents automatically

opt.smartcase = true            -- Don't ignore case with capitals
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true

opt.autoread = true
opt.title = true
opt.swapfile = false
opt.backup = false
opt.spelllang = { "en" }
opt.termguicolors = true        -- True color support
opt.signcolumn = "yes"          -- Always show the signcolumn, otherwise it would shift the text each time
opt.virtualedit = "block"       -- Allow cursor to move where there is no text in visual block mode
opt.mouse = ""                  -- Disable mouse mode
opt.wrap = true                 -- Enable line wrap
-- opt.breakindent = true          -- set indents when wrapped
opt.splitright = true           -- Put new windows right of current
opt.splitbelow = true           -- Put new windows below current
opt.listchars = {
    tab = "▏┈",
    -- lead = "›",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "░"
}
opt.list = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
-- opt.foldmarker = "<!--,-->"
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = "⸱",
    foldsep = " ",
    diff = "╱",
    eob = " ",
    vert = "▒",
}

opt.diffopt = {
    "internal",
    "filler",
    "closeoff",
    "algorithm:histogram",
    "indent-heuristic",
}

