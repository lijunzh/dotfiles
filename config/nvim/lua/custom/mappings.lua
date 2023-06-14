local M = {}

M.disabled = {
	n = {
		["<C-n>"] = "", -- undo NvimTreeToggle, use - instead
		["<C-s>"] = "", -- undo save buffer, use <leader>w instead
	}
}

M.general = {
	n = {
		["<leader>w"] = { ":w <CR> ", "save buffer" },
		["<leader>k"] = { ":q <CR> ", "close window" },
		[";"] = { ":", "command mode", opts = { nowait = true } },
	},
	i = {
		["jk"] = { "<ESC>", "escape insert mode" },
	},
}

M.nvimtree = {
	n = {
		["-"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
	},
}

return M
