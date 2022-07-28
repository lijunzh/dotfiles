return {
	-- autosave
	["Pocco81/AutoSave.nvim"] = {
		config = function()
			local autosave = require("autosave")

			autosave.setup({
				enabled = true,
				execution_message = "autosaved at : " .. vim.fn.strftime("%H:%M:%S"),
				events = { "FocusLost" },
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

	-- lsp
["neovim/nvim-lspconfig"] = {
	config = function()
		require "plugins.configs.lspconfig"
		require "custom.plugins.lspconfig"
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
