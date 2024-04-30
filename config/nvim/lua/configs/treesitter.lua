return {
	ensure_installed = {
		"bash",
		"c",
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"toml",
		"tsx",
		"typescript",
		"vim",
	},

	indent = {
		enable = true,
		disable = { "python" },
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
}
