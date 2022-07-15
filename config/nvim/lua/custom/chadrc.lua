local M = {}

local override = require("custom.plugins.override")

M.plugins = {
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},

		statusline = {
			separator_style = "round",
		},
	},

	override = {
		["hrsh7th/nvim-cmp"] = function()
			local cmp = require "cmp"
			local source_mapping = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				cmp_tabnine = "[TN]",
				path = "[Path]",
			}
			return {
				sources = {
					 { name = "cmp_tabnine" },
					 { name = "nvim_lsp" },
					 { name = "luasnip" },
					 { name = "buffer" },
					 { name = "nvim_lua" },
					 { name = "path" },
				 },
			 
				 formatting = {
					 format = function(entry, vim_item)
						 local icons = require("nvchad_ui.icons").lspkind
						 vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			 
						 local menu = source_mapping[entry.source.name]
						 if entry.source.name == "cmp_tabnine" then
							 if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
								 menu = entry.completion_item.data.detail .. " " .. menu
							 end
							 vim_item.kind = ""
						 end
						 vim_item.menu = menu
			 
						 return vim_item
					 end,
				 },
			 
				 mapping = {
					 ["<C-p>"] = cmp.mapping.select_prev_item(),
					 ["<C-n>"] = cmp.mapping.select_next_item(),
					 ["<C-e>"] = cmp.mapping.close(),
					 ["<CR>"] = cmp.mapping.confirm({
						 behavior = cmp.ConfirmBehavior.Replace,
						 select = true,
					 }),
					 ["<Tab>"] = cmp.config.disable,
					 ["<S-Tab>"] = cmp.config.disable,
				 },
			 }
		end,
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
		["nvim-treesitter/nvim-treesitter"] = override.treesitter,
	},

	user = require "custom.plugins",
}

M.ui = {
	theme = "gruvchad",
}

M.options = {
	user = function()
		require("custom.options")
	end,
}

M.mappings = require("custom.mappings")

return M
