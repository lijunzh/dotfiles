local options = {

	-- lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },

		css = { "biome" },
		html = { "biome" },
		json = { "biome" },
		jsonc = { "biome" },

    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,

    rust = { "rustfmt" },

		markdown = { "deno_fmt" },
		sh = { "shfmt" },
		yaml = { "yamlfmt" },
	},

	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 500,
	-- 	lsp_fallback = true,
	-- },
}

-- require("conform").setup(options)

return options
