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
		["jk"] = { "<ESC>", "escape vim" },
	},
}

M.nvimtree = {
	n = {
		["-"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
	},
}

M.packer = {
	n = {
		["<C-p>c"] = { ":PackerClean <CR>", "packer clean" },
		["<C-p>s"] = { ":PackerSync <CR>", "packer sync" },
	},
}

return M
