--------------------------------------------------------------------------------
-- editor
--------------------------------------------------------------------------------

-- Override the default tab stop
vim.g.tabstop = 2

-- Map local leader key
vim.g.maplocalleader = ","

-- have some line above and below cursor
vim.opt.scrolloff = 8

-- control backspace behavior
vim.opt.backspace = "" -- legacy backspace behavior

--------------------------------------------------------------------------------
-- appearance
--------------------------------------------------------------------------------

vim.opt.showmatch = true

-- line wrap
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showbreak = "↪"

-- list
vim.opt.list = true
vim.opt.listchars = "tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮,space:·"

-- 79 column line
-- excpetions for git and text file are defined in utils.lua
vim.opt.textwidth = 79
vim.opt.colorcolumn = "+1"