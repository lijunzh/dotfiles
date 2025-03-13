---@type NvPluginSpec[]
return {
	--------------------------------------- default plugins -----------------------------------------
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				config = function(_, opts)
					require("luasnip").config.set_config(opts)

					local luasnip = require("luasnip")

					luasnip.filetype_extend("javascriptreact", { "html" })
					luasnip.filetype_extend("typescriptreact", { "html" })
					luasnip.filetype_extend("svelte", { "html" })

					require("nvchad.configs.luasnip")
				end,
			},
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				config = function()
					require("copilot").setup({
						suggestion = { enabled = false }, -- Disable inline suggestions if needed
						panel = { enabled = false }, -- Disable floating panel if needed
					})
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				dependencies = { "zbirenbaum/copilot.lua" },
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		opts = require("configs.cmp"),
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("configs.treesitter"),
	},

	{
		"numToStr/Comment.nvim",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
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
			require("shade").setup({
				exclude_filetypes = { "NvimTree" },
			})
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

	-- markdown preview
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				auto_load = true, -- whether to automatically load preview when entering another markdown buffer
				close_on_bdelete = true, -- close preview window on buffer delete
				syntax = true, -- enable syntax highlighting, affects performance
				theme = "dark", -- 'dark' or 'light'
				update_on_change = true,
				app = "webview", -- 'webview', 'browser', string or a table of strings explained below
				filetype = { "markdown" }, -- list of filetypes to recognize as markdown relevant if update_on_change is true
				throttle_at = 200000, -- start throttling when file exceeds this amount of bytes in size
				throttle_time = "auto", -- minimum amount of time in milliseconds that has to pass before starting new render
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}
