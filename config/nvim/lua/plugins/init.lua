return {

	--------------------------------------- default plugins -----------------------------------------
	{
		"hrsh7th/nvim-cmp",
		opts = require "configs.cmp",
		dependencies = {
			{
				"jcdickinson/codeium.nvim",
				config = function()
					require("codeium").setup {}
				end,
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require "configs.lspconfig"
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		config = function()
			require "configs.conform"
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = require "configs.nvimtree",
	},

	{
		"williamboman/mason.nvim",
		opts = require "configs.mason",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = require "configs.treesitter",
	},

	{
		"numToStr/Comment.nvim",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("Comment").setup {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
	},

	--------------------------------------------- custom plugins ----------------------------------------------
	-- smooth scroll
	{
		"karb94/neoscroll.nvim",
		keys = { "<C-d>", "<C-u>" },
		config = function()
			require("neoscroll").setup()
		end,
	},

	-- dim inactive windows
	{
		"andreadev-it/shade.nvim",
		config = function()
			require("shade").setup {
				exclude_filetypes = { "NvimTree" },
			}
		end,
	},

	-- pretty diagnostics panel
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TodoTrouble" },
		dependencies = {
			{
				"folke/todo-comments.nvim",
				opts = {},
			},
		},
		config = function()
			require("trouble").setup()
		end,
	},
}
