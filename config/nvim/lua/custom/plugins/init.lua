return {
	------------------------------ default plugins ------------------------------

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	["kyazdani42/nvim-tree.lua"] = {
		override_options = {
			git = {
				enable = true,
			},
			renderer = {
				highlight_git = true,
				icons = {
					show = {
						git = true,
					},
				},
			},
		},
	},

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = {
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
			 	"yaml",
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
					rust = {
							'impl_item',
					},
				},
				exact_patterns = {
					-- Example for a specific filetype with Lua patterns
					-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
					-- exactly match "impl_item" only)
					rust = true,
				},
			},
		},
	},

	["lukas-reineke/indent-blankline.nvim"] = {
		override_options = {
			filetype_exclude = {
				"help",
				"terminal",
				"alpha",
				"packer",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
				"nvchad_cheatsheet",
				"lsp-installer",
				"norg",
				"",
			},
		},
	},

	["williamboman/mason.nvim"] = {
		override_options = {
			ensure_installed = {
				-- c/cpp
				"clang-format",

				-- lua stuff
				"lua-language-server",
				"stylua",

				-- python
				"pyright",
				"black",
				"isort",

				-- rust
				"rust-analyzer",

				-- web dev
				"css-lsp",
				"html-lsp",
				"typescript-language-server",
				"deno",
				"emmet-ls",
				"json-lsp",

				-- shell
				"bash-language-server",
				"shfmt",
				"shellcheck",

				-- latex
				"texlab",

				-- yaml
				"yaml-language-server",
			},
		}
	},

	------------------------------ custom plugins ------------------------------

	-- autosave
	["Pocco81/AutoSave.nvim"] = {
    module = "autosave",
		config = function()
			require("autosave").setup()
		end,
	},

	-- formating tool
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	-- nvim-treesitter extensions
	["p00f/nvim-ts-rainbow"] = {
		event = "BufRead",
	},
	["nvim-treesitter/nvim-treesitter-textobjects"] = {
		event = "BufRead",
	},
	["JoosepAlviste/nvim-ts-context-commentstring"] = {
		event = "BufRead",
	},
	["romgrk/nvim-treesitter-context"] = {
		event = "BufRead",
	},
	["windwp/nvim-ts-autotag"] = {
		ft = { "html", "javascriptreact" },
		after = "nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- utils
	["KenN7/vim-arsync"] = {
		cmd = {
			"ARsyncUp",
			"ARsyncConf",
			"ARsyncDown",
			"ARsyncUpDelete",
		},
	},
}
