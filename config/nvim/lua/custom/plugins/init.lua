return {
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
