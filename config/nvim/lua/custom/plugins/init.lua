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

   -- smooth scroll
	["karb94/neoscroll.nvim"] = {
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
	["luukvbaal/stabilize.nvim"] = {
		config = function()
			require("stabilize").setup()
		end,
	},

   -- lsp
	["onsails/lspkind-nvim"] = {
		after = "nvim-lspconfig",
	},

   -- formating tool
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
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

   -- ai tools
	["tzachar/cmp-tabnine"] = {
		after = "nvim-cmp",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		config = function()
			require("custom.plugins.tabnine").setup()
		end,
	},
	["github/copilot.vim"] = {
		event = "InsertEnter",
		-- config = function()
		-- 	vim.g.copilot_assume_mapped = true
		-- 	vim.g.copilot_no_tab_map = true 
		-- 	vim.g.copilot_copilot_tab_fallback = ""
		-- end,
	},

   -- utils
	["folke/which-key.nvim"] = {
		config = function()
			require("which-key").setup({})
		end,
	},
	["KenN7/vim-arsync"] = {
		cmd = {
			"ARsyncUp",
			"ARsyncConf",
			"ARsyncDown",
			"ARsyncUpDelete",
		},
	},
}
