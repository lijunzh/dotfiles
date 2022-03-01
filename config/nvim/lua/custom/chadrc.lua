local M = {}

local user_plugins = require("custom.plugins")
local default_plugins_user_config = require("custom.plugins.configs")

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.options = {
	-- custom options
	backspace = "", -- legacy backspace behavior
	colorcolumn = "+1",
	expandtab = false,
	linebreak = true,
	list = true,
	listchars = "tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮,space:·",
	maplocalleader = ",",
	showbreak = "↪",
	showmatch = true,
	scrolloff = 8,
	splitbelow = true,
	splitright = true,
	textwidth = 79,
	wrap = false,
}

M.ui = {
	theme = "gruvchad",
}

M.plugins = {

	-- enable/disable plugins (false for disable)
	status = {
		blankline = true, -- indentline stuff
		bufferline = true, -- manage and preview opened buffers
		colorizer = true, -- color RGB, HEX, CSS, NAME color codes
		comment = true, -- easily (un)comment code, language aware
		alpha = true, -- dashboard
		better_escape = true, -- map to <ESC> with no lag
		feline = true, -- statusline
		gitsigns = true,
		lspsignature = true, -- lsp enhancements
		vim_matchup = true, -- improved matchit
		cmp = true,
		nvimtree = true,
		autopairs = true,
	},

	-- setup lsp servers
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},
	},

	default_plugin_config_replace = {
		nvim_tree = default_plugins_user_config.nvimtree,
		nvim_treesitter = default_plugins_user_config.treesitter,
	},

	-- custom plugins
	install = user_plugins,
}

M.mappings = {

	misc = {
		copy_whole_file = "", -- disable copy all contents of current buffer
		save_file = "<leader>w", -- save file using :w
	},

	-- terminal related mappings
	terminal = {
		-- spawn terminals
		new_horizontal = "<leader>ts",
		new_vertical = "<leader>tv",
		new_window = "<leader>tw",
	},
}

-- plugins related mappings
-- To disable a mapping, equate the variable to "" or false or nil in chadrc
M.mappings.plugins = {
	comment = {
		toggle = "gc",
	},

	lspconfig = {
		set_loclist = "<leader>ll",
		formatting = "<leader>lfm",
	},

	nvimtree = {
		toggle = "-",
	},
}

return M
