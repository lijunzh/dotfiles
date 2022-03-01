local options = require("core.utils").load_config().options

--------------------------------------------------------------------------------
-- editor
--------------------------------------------------------------------------------

-- Map local leader key
vim.g.maplocalleader = ","

-- have some line above and below cursor
vim.opt.scrolloff = 8

-- control backspace behavior
vim.opt.backspace = ""

-- file extension specific tabbing
vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
vim.cmd([[autocmd Filetype lua setlocal expandtab tabstop=3 shiftwidth=3 softtabstop=3]])

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

-- highlight on yank
vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")
