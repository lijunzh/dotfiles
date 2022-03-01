local M = {}

M.setup_lsp = function(attach, capabilities)
	local lspconfig = require("lspconfig")

	-- lspservers with default config
	local servers = { "pyright" }

	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			on_attach = attach,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 150,
			},
		})
	end

	-- lua
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	require("lspconfig").sumneko_lua.setup({
		on_attach = attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

return M
