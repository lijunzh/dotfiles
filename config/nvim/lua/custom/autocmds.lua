-- reload buffer when file changes on disk and warn user
vim.api.nvim_exec(
	[[
augroup file_change
   autocmd!
   autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
   autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]],
	false
)

-- remove tailing white space and empty line at the end of file
vim.api.nvim_exec(
	[[
augroup auto_save_remove_white_space
   autocmd!
   autocmd BufWritePre * silent! s/\s\+$//e
   autocmd BufWritePre * silent! %s#\($\n\s*\)\+\%$##
augroup END
]],
	false
)

-- 79 column line exceptions
vim.api.nvim_exec(
	[[
augroup column_width
   autocmd!
   " no text wrap for text files
   autocmd Filetype tex,plaintex,markdown,text setlocal tw=0 wrap
   " 72 columns for git commit
   autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END
]],
	false
)

local autocmd = vim.api.nvim_create_autocmd

-- Open nvim with a dir
autocmd("BufEnter", {
   callback = function()
      if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
         vim.cmd "lcd %:p:h"
      end
   end,
})

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
autocmd("InsertEnter", {
   callback = function()
      vim.opt.relativenumber = false
   end,
})
autocmd("InsertLeave", {
   callback = function()
      vim.opt.relativenumber = true
   end,
})

-- Open a file from its last left off position
autocmd("BufReadPost", {
   callback = function()
      if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
         vim.cmd "normal! g'\""
         vim.cmd "normal zz"
      end
   end,
})

-- File extension specific tabbing
autocmd("Filetype", {
   pattern = "python",
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
   end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
   end,
})

-- Enable spellchecking in markdown, text and gitcommit files
autocmd("FileType", {
   pattern = { "gitcommit", "markdown", "text" },
   callback = function()
      vim.opt_local.spell = true
   end,
})