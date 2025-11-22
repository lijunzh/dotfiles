require("nvchad.configs.lspconfig").defaults()

local servers = {
	"ruff",
	"html",
	"cssls",
	"clangd",
	"jsonls",
	"yamlls",
	"bashls",
	"taplo",
	"texlab",
	"rust_analyzer",
	"lua_ls",
}
vim.lsp.enable(servers)

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" },
			cargo = { allFeatures = true },
			-- your usual rust-analyzer tweaks
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})
