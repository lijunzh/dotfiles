require("nvchad.configs.lspconfig").defaults()

local servers = {
	"bashls",
	"clangd",
	"jsonls",
	"lua_ls",
	"ruff",
	"rust_analyzer",
	"taplo",
	"texlab",
	"yamlls",
}
vim.lsp.enable