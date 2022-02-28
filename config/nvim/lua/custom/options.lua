local options = require("core.utils").load_config().options

--------------------------------------------------------------------------------
-- editor
--------------------------------------------------------------------------------

-- Map local leader key
vim.g.maplocalleader = options.maplocalleader

-- have some line above and below cursor
vim.opt.scrolloff = options.scrolloff

-- control backspace behavior
vim.opt.backspace = options.backspace

-- file extension specific tabbing
vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
vim.cmd([[autocmd Filetype lua setlocal expandtab tabstop=3 shiftwidth=3 softtabstop=3]])

--------------------------------------------------------------------------------
-- appearance
--------------------------------------------------------------------------------

vim.opt.showmatch = options.showmatch

-- line wrap
vim.opt.wrap = options.wrap
vim.opt.linebreak = options.linebreak
vim.opt.showbreak = options.showbreak

-- list
vim.opt.list = options.list
vim.opt.listchars = options.listchars

-- 79 column line
-- excpetions for git and text file are defined in utils.lua
vim.opt.textwidth = options.textwidth
vim.opt.colorcolumn = options.colorcolumn

-- highlight on yank
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')
