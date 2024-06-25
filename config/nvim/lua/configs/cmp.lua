local options = {
	sources = {
		-- trigger_characters is for unocss lsp
		{ name = "codeium" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
	},
	experimental = {
		ghost_text = true,
	},
}

-- require("cmp").setup(options)

return options
