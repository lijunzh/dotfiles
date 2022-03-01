local plugin_settings = require("core.utils").load_config().plugins

local custom_plugins = {
	-- autosave
	{
		"Pocco81/AutoSave.nvim",
		config = function()
			local autosave = require("autosave")

			autosave.setup({
				enabled = true,
				execution_message = "autosaved at : " .. vim.fn.strftime("%H:%M:%S"),
				events = { "FocusLost", "InsertLeave", "TextChanged" },
				conditions = {
					exists = true,
					filetype_is_not = {},
					modifiable = true,
				},
				clean_command_line_interval = 2500,
				on_off_commands = true,
				write_all_buffers = false,
			})
		end,
	},

	-- smooth scroll
	{
		"karb94/neoscroll.nvim",
		opt = true,
		config = function()
			require("neoscroll").setup()
		end,

		-- lazy loading
		setup = function()
			require("core.utils").packer_lazy_load("neoscroll.nvim")
		end,
	},

	-- stabilize window open/close
	{
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	},

	-- lsp
	{
		"onsails/lspkind-nvim",
		disable = not plugin_settings.status.lspsignature,
		after = "nvim-lspconfig",
	},

	-- formating tool
	{
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls").setup()
		end,
	},

	-- nvim-treesitter extensions
	{
		"p00f/nvim-ts-rainbow",
		event = "BufRead",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufRead",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
	},
	{
		"romgrk/nvim-treesitter-context",
		event = "BufRead",
	},

	-- ai tools
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			vim.cmd([[
            imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
            let g:copilot_no_tab_map = v:true
         ]])
		end,
	},

	-- utils
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	},
	{
		"KenN7/vim-arsync",
		cmd = {
			"ARsyncUp",
			"ARsyncConf",
			"ARsyncDown",
			"ARsyncUpDelete",
		},
	},
}

return custom_plugins
