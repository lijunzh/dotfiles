local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {

	-- cpp
	b.formatting.clang_format,

	-- webdev stuff
	b.formatting.deno_fmt,
	b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }),

	-- Lua
	b.formatting.stylua,

	-- python
	b.formatting.black,
	b.formatting.isort,

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
}

local M = {}

M.setup = function()
	null_ls.setup({
		debug = true,
		sources = sources,
		-- on_attach = function(client)
		-- 	if client.resolved_capabilities.document_formatting then
		-- 		vim.cmd([[
		-- 			nmap <leader>fm :lua vim.lsp.buf.formatting_sync()<CR>
		-- 		]])
		-- 	end
		-- end,
	})
end

return M
