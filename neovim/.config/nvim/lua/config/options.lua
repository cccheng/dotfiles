-- Documentation: https://neovim.io/doc/user/options.html

local opt = vim.opt

opt.autoindent = true
opt.breakindent = true                                  -- Indent wrapped lines to match line start
opt.breakindentopt = "list:-1"                          -- Add padding for lists (if 'wrap' is set)
opt.colorcolumn = "+1"                                  -- Draw column on the right of maximum width
opt.cursorline = true                                   -- Enable highlighting of the current line
opt.cursorlineopt = "screenline,number"                 -- Highlight the screen line of the cursor with CursorLine and the line number with CursorLineNr
opt.expandtab = true
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = "╌",
    foldsep = " ",
    diff = "╱",
    eob = " ",
    vert = "▒",
}
opt.foldcolumn = "0"                                    -- Don't show the fold column
opt.foldenable = false
-- opt.foldmarker = "<!--,-->"
opt.foldmethod = "indent"
opt.formatoptions = "cjlnoqrt"                          -- Improve comment editing. Ref: 'fo-table'
opt.ignorecase = true                                   -- Ignore case during search
opt.incsearch = true                                    -- Show search matches while typing
opt.linebreak = true                                    -- Wrap lines at 'breakat' (if 'wrap' is set)
opt.list = false                                        -- Don't show whitespace characters
opt.listchars = {
    tab = "▏┈",
    -- lead = "›",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "░"
}
opt.mouse = "a"                                         -- Enable mouse
opt.mousescroll = "ver:25,hor:6"                        -- Customize mouse scroll
opt.number = true                                       -- Print line number
opt.pumheight = 30                                      -- Maximum number of entries in a popup
opt.ruler = false                                       -- Don't show the cursor position since we have a statusline
opt.shiftwidth = 4                                      -- Use this number of spaces for indentation
opt.shortmess:append {
    c = true,                                           -- Don't show completion messages in command line
    I = true,                                           -- Don't show the intro message
}
opt.showmode = false                                    -- Don't show mode since we have a statusline
opt.signcolumn = "yes"                                  -- Always show the signcolumn (less flicker)
opt.smartcase = true                                    -- Don't ignore case with capitals
opt.smartindent = true                                      -- Insert indents automatically
opt.splitbelow = true                                   -- Put new windows below current
opt.splitkeep = "screen"   -- Reduce scroll during window split
opt.splitright = true                                   -- Put new windows right of current
opt.switchbuf = "usetab"                                -- Use already opened buffers when switching
--[[
  ShDa (viminfo for vim): session data history
  --------------------------------------------
  ! - Save and restore global variables (their names should be without lowercase letter).
  ' - Specify the maximum number of marked files remembered. It also saves the jump list and the change list.
  < - Maximum of lines saved for each register. All the lines are saved if this is not included, <0 to disable pessistent registers.
  % - Save and restore the buffer list. You can specify the maximum number of buffer stored with a number.
  / or : - Number of search patterns and entries from the command-line history saved. o.history is used if it’s not specified.
  f - Store file (uppercase) marks, use 'f0' to disable.
  s - Specify the maximum size of an item’s content in KiB (kilobyte).
      For the viminfo file, it only applies to register.
      For the shada file, it applies to all items except for the buffer list and header.
  h - Disable the effect of 'hlsearch' when loading the shada file.

  :oldfiles - all files with a mark in the shada file
  :rshada   - read the shada file (:rviminfo for vim)
  :wshada   - write the shada file (:wrviminfo for vim)
]]
opt.shada = [[!,'100,<50,f100,s100,:1000,/100,@100,h]]
opt.undofile = true                                     -- Enable persistent undo
opt.wrap = true                                         -- Enable line wrap





opt.cmdheight = 0                                       -- Use native cmdheight=0 (Neovim 0.8+)

opt.ttyfast = true                                      -- Fast terminal connection
opt.updatetime = 50                                     -- Faster CursorHold events (default 4000ms)
opt.timeoutlen = 300                                    -- Faster key sequence timeout
opt.ttimeoutlen = 10                                    -- Faster key code timeout
opt.redrawtime = 1500                                   -- Time limit for syntax highlighting
opt.synmaxcol = 200                                     -- Limit syntax highlighting to 200 columns

opt.clipboard = "unnamedplus"                           -- Sync with system clipboard
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit"                              -- preview incremental substitute
opt.laststatus = 3                                      -- global statusline
opt.pumblend = 10                                       -- Popup blend

opt.relativenumber = true                               -- Relative line numbers
opt.backspace = {"indent", "eol", "start"}
opt.scrolloff = 4                                       -- Lines of context
opt.smoothscroll = true
opt.winminwidth = 5                                     -- Minimum window width

-- opt.wildmenu = true
-- opt.wildmode = "longest:full,full"                      -- Command-line completion mode
-- opt.wildmode = "list:longest"                           -- Command-line completion mode

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
opt.completeopt = {"menu", "menuone", "noinsert", "noselect"}

opt.modeline = true

opt.tabstop = 8                                             -- Number of spaces tabs count for
opt.softtabstop = 4
opt.shiftround = true                                       -- Round indent

opt.hlsearch = true

opt.autoread = true
opt.title = true
opt.swapfile = false
opt.backup = false
opt.spelllang = { "en" }
opt.termguicolors = true                                    -- True color support
opt.virtualedit = "block"                                   -- Allow cursor to move where there is no text in visual block mode
opt.diffopt = {
    "internal",
    "filler",
    "closeoff",
    "algorithm:histogram",
    "indent-heuristic",
}

