local M = {}

M.misc = {
	n = {
		["<leader>w"] = { ":w <CR> ", "   save buffer" },
		["<leader>k"] = { ":q <CR> ", "   close window" },
	},
}

M.packer = {
	n = {
		["<C-p>c"] = { ":PackerClean <CR>", "   packer clean" },
		["<C-p>s"] = { ":PackerSync <CR>", "   packer sync" },
	},
}

return M
