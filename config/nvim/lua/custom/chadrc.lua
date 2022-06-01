local M = {}

local override = require("custom.plugins.override")

M.plugins = {
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},

		statusline = {
			separator_style = "round",
		},
	},

	override = {
		["hrsh7th/nvim-cmp"] = override.cmp,
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
		["nvim-treesitter/nvim-treesitter"] = override.treesitter,
	},

	user = require "custom.plugins",
}

M.ui = {
	theme = "gruvchad",
}

M.options = {
	user = function()
		require("custom.options")
	end,
	disable_default_plugins = {
		"2html_plugin",
		"getscript",
		"getscriptPlugin",
		"gzip",
		"logipat",
		"matchit",
		"tar",
		"tarPlugin",
		"rrhelper",
		"spellfile_plugin",
		"vimball",
		"vimballPlugin",
		"zip",
		"zipPlugin",
	},
}

M.mappings = require("custom.mappings")

return M
