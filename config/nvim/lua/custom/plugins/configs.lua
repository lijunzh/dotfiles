local M = {}

M.nvimtree = {
	git = {
		enable = true,
	},
}

-- overriding default plugin configs!
M.treesitter = {
	ensure_installed = {
		"bash",
		"c",
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"rust",
		"toml",
		"vim",
	},

	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 1000,
	},

	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},

	matchup = {
		enable = true,
	},

	context = {
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		throttle = true, -- Thottles plugin updates (may improve performance)
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
			-- For all filetypes
			-- Note that setting an entry here replaces all other patterns for this entry.
			-- By setting the 'default' entry below, you can control which nodes you want to
			-- appear in the context window.
			default = {
				"class",
				"function",
				"method",
				"for",
				"if",
				-- 'while', -- These won't appear in the context
				-- 'switch',
				-- 'case',
			},
			-- Example for a specific filetype.
			-- If a pattern is missing, *open a PR* so everyone can benefit.
			--   rust = {
			--       'impl_item',
			--   },
		},
		exact_patterns = {
			-- Example for a specific filetype with Lua patterns
			-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
			-- exactly match "impl_item" only)
			-- rust = true,
		},
	},
}

return M
