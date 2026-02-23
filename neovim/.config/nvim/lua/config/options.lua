-- Documentation: https://neovim.io/doc/user/options.html

local opt = vim.opt

opt.autoindent = true
opt.autoread = true
opt.backspace = {"indent", "eol", "start"}
opt.backup = false
opt.breakindent = true                                  -- Indent wrapped lines to match line start
opt.breakindentopt = "list:-1"                          -- Add padding for lists (if 'wrap' is set)
opt.clipboard = "unnamedplus"                           -- Sync with system clipboard
opt.cmdheight = 0                                       -- Hide the command bar
opt.colorcolumn = "+1"                                  -- Draw column on the right of maximum width
--[[
  Set completeopt to have a better completion experience
  :help 'completeopt'
  menuone: popup even when there's only one match
  menu: Show a popup menu for completions, even if there's only one match.
  menuone: Show the menu even when there's only one completion candidate.
  noinsert: Do not insert text until a selection is made
  noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
]]
opt.completeopt = {"menu", "menuone", "noinsert", "noselect", "fuzzy", "nosort"}
opt.cursorline = true                                   -- Enable highlighting of the current line
opt.cursorlineopt = "screenline,number"                 -- Highlight the screen line of the cursor with CursorLine and the line number with CursorLineNr
opt.diffopt = {
    "internal",
    "filler",
    "closeoff",
    "algorithm:histogram",
    "indent-heuristic",
}

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
opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]    -- Pattern for a start of numbered list (used in `gw`). This reads as
                                                        -- "Start of list item is: at least one special character (digit, -, +, *)
                                                        -- possibly followed by punctuation (. or `)`) followed by at least one space".

opt.formatoptions = "cjlnoqrt"                          -- Improve comment editing. :help 'fo-table'
-- opt.grepformat = "%f:%l:%c:%m"
-- opt.grepprg = "rg --vimgrep -uu"
opt.hlsearch = true
opt.ignorecase = true                                   -- Ignore case during search
opt.inccommand = "nosplit"                              -- preview incremental substitute
opt.incsearch = true                                    -- Show search matches while typing
--[[
  Treat dash as `word` textobject part
  @: All alphabetic characters (letters a-z, A-Z)
  48-57: ASCII codes for digits 0-9
  _:  Underscore character
  192-255: Extended ASCII characters (accented letters like é, ñ, ü)
  -: Dash/hyphen character (the addition)
]]
opt.iskeyword = '@,48-57,_,192-255,-'
opt.laststatus = 3                                      -- Use global statusline
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
opt.modeline = true
opt.mouse = "a"                                         -- Enable mouse
opt.mousescroll = "ver:25,hor:6"                        -- Customize mouse scroll
opt.number = true                                       -- Print line number
opt.numberwidth = 3                                     -- Make the line number column thinner
opt.pumblend = 10                                       -- Popup blend
opt.pumheight = 30                                      -- Maximum number of entries in a popup
opt.relativenumber = true                               -- Relative line numbers
opt.ruler = false                                       -- Don't show the cursor position since we have a statusline
opt.scrolloff = 3                                       -- Lines of context
opt.shiftround = true                                   -- Round indent
opt.shiftwidth = 4                                      -- Use this number of spaces for indentation
opt.shortmess:append {
    c = true,                                           -- Don't show completion messages in command line
    I = true,                                           -- Don't show the intro message
}
-- opt.showmatch = true -- Show matching brackets by flickering
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
opt.softtabstop = 4                                     -- Number of spaces tabs count for
opt.smoothscroll = true
opt.synmaxcol = 500                                     -- Limit syntax highlighting to 500 columns
opt.swapfile = false
opt.tabstop = 8                                         -- Number of spaces in a tab
opt.termguicolors = true                                    -- True color support
opt.title = true
opt.timeoutlen = 300                                    -- Time in milliseconds to wait for a mapped sequence to complete
opt.ttimeoutlen = 10                                    -- Faster key code timeout
opt.undofile = true                                     -- Enable persistent undo between sessions
opt.updatetime = 50                                     -- Faster CursorHold events (default 4000ms)
opt.virtualedit = "block"                               -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5                                     -- Minimum window width
opt.wrap = true                                         -- Enable line wrap
-- opt.wrapmargin = 1

