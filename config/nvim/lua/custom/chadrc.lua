local M = {}
local override = require("custom.plugins.override")

M.plugins = {

	override = {
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
		["nvim-treesitter/nvim-treesitter"] = override.treesitter,
		["lukas-reineke/indent-blankline.nvim"] = override.blankline,
		["williamboman/mason.nvim"] = override.mason,
	},

	user = require("custom.plugins"),
}

M.ui = {
	theme = "gruvchad",
}

M.mappings = require("custom.mappings")

return M
