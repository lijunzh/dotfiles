require("nvchad.autocmds")

local autocmd = vim.api.nvim_create_autocmd

autocmd("CmdlineEnter", {
	callback = function()
		require("commands")
	end,
})

-- Reload buffer when file changes on disk and warn user
-- reference: https://neovim.discourse.group/t/a-lua-based-auto-refresh-buffers-when-they-change-on-disk-function/2482/8
vim.o.autoread = true
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
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

-- Persistent Cursor
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Cursor Line on each window
autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
})

-- Force markdown filetype on .md files (Neovim sometimes guesses wrong)
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.md",
  command = "set filetype=markdown",
})

-- File extension specific indentation
autocmd("Filetype", {
	pattern = "python",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})
autocmd("Filetype", {
	pattern = { "lua", "tex" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Spell checking
autocmd("FileType", {
	pattern = { "gitcommit", "gitrebase", "markdown", "text" },
	callback = function()
		vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
	end,
})
