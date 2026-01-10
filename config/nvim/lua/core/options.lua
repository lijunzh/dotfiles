-- ============================================================================
-- Vim Options
-- ============================================================================

local opt = vim.opt

-- ============================================================================
-- General
-- ============================================================================

opt.mouse = "a"               -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.swapfile = false          -- Disable swap file
opt.undofile = true           -- Enable persistent undo
opt.updatetime = 250          -- Faster completion
opt.timeoutlen = 300          -- Time to wait for mapped sequence

-- ============================================================================
-- Editor
-- ============================================================================

-- Tabs and indentation
opt.tabstop = 8       -- Tab width
opt.shiftwidth = 8    -- Indent width
opt.softtabstop = 8   -- Soft tab width
opt.expandtab = false -- Use tabs, not spaces

-- Scrolling
opt.scrolloff = 8     -- Lines above/below cursor
opt.sidescrolloff = 8 -- Columns left/right of cursor

-- Backspace behavior
opt.backspace = "" -- Legacy backspace behavior

-- Search
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true  -- Unless uppercase is used
opt.hlsearch = true   -- Highlight search results
opt.incsearch = true  -- Incremental search

-- Splits
opt.splitbelow = true -- Horizontal splits below
opt.splitright = true -- Vertical splits to the right

-- ============================================================================
-- Appearance
-- ============================================================================

opt.number = true         -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true     -- Highlight current line
opt.signcolumn = "yes"    -- Always show sign column
opt.termguicolors = true  -- True color support
opt.showmode = false      -- Don't show mode (statusline shows it)

-- Matching
opt.showmatch = true -- Highlight matching brackets

-- Line wrapping
opt.wrap = false -- Don't wrap lines
opt.linebreak = true -- Break at word boundaries (when wrap is on)
opt.showbreak = "↪" -- Show line break indicator

-- Whitespace characters
opt.list = true -- Show whitespace characters
opt.listchars = {
    tab = "→ ",
    eol = "¬",
    trail = "⋅",
    extends = "❯",
    precedes = "❮",
    space = "·",
}

-- Text width
opt.textwidth = 79     -- Maximum text width
opt.colorcolumn = "+1" -- Highlight column after textwidth

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10 -- Popup menu height

-- ============================================================================
-- Statusline (minimal native)
-- ============================================================================

opt.laststatus = 2 -- Always show statusline
opt.statusline = " %f %m%r%h%w%=%y [%l/%L, %c] "
