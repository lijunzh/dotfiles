-- This file	needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "gruvchad",

	cmp = {
		style = "atom",
	},
}

M.mason = {
	pkgs = {
		-- lua
		"lua-language-server",
		"stylua",

		-- python
		"ruff",

		-- web dev
		"css-lsp",
		"html-lsp",
		"prettier",

		-- rust
		"rust-analyzer",

		-- shell
		"bash-language-server",
		"shfmt",
		"shellcheck",

		-- toml
		"taplo",

		-- latex
		"texlab",

		-- yaml
		"yaml-language-server",
		"yamlfmt",
	}
}

return M
