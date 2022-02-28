-- hybrid line number
vim.api.nvim_exec([[
augroup hybrid_line_number
   autocmd!
   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
   autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
]], false)

-- reload buffer when file changes on disk and warn user
vim.api.nvim_exec([[
augroup file_change
   autocmd!
   autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
   autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]], false)

-- remove tailing white space and empty line at the end of file
vim.api.nvim_exec([[
augroup auto_save_remove_white_space
   autocmd!
   autocmd BufWritePre * silent! s/\s\+$//e
   autocmd BufWritePre * silent! %s#\($\n\s*\)\+\%$##
augroup END
]], false)
