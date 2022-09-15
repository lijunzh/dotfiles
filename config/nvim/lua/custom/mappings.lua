local M = {}

M.general = {
	n = {
		["<leader>w"] = { ":w <CR> ", "   save buffer" },
		["<leader>k"] = { ":q <CR> ", "   close window" },
	},
}

M.nvimtree = {
	n = {
		["-"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
	},
}

M.packer = {
	n = {
		["<C-p>c"] = { ":PackerClean <CR>", "   packer clean" },
		["<C-p>s"] = { ":PackerSync <CR>", "   packer sync" },
	},
}

return M
