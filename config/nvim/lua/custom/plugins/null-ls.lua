local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {

	-- lua
	b.formatting.stylua,
	b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

	-- python
	b.formatting.black,
	b.formatting.isort,

	-- shell
	b.formatting.shfmt,
}

local M = {}

M.setup = function()
	null_ls.setup({
		debug = true,
		sources = sources,
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd([[
					nnmap <leader>fm :lua vim.lsp.buf.formatting_sync()<CR>
				]])
			end
		end,
	})
end

return M
