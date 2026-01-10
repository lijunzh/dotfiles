-- ============================================================================
-- LSP Configuration
-- ============================================================================

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================

vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        spacing = 4,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
})

-- Diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- ============================================================================
-- LSP Keymaps (set on attach)
-- ============================================================================

local on_attach = function(client, bufnr)
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gr", vim.lsp.buf.references, "Go to references")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

    -- Documentation
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Actions
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
end

-- ============================================================================
-- Capabilities (for completion)
-- ============================================================================

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Add cmp capabilities if nvim-cmp is available
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- ============================================================================
-- Server Configurations
-- ============================================================================

local server_configs = {
    -- Lua
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },

    -- Rust
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                check = { command = "clippy" },
                cargo = { allFeatures = true },
            },
        },
    },

    -- Python
    ruff = {},

    -- Shell
    bashls = {},

    -- TOML
    taplo = {},

    -- LaTeX
    texlab = {},

    -- YAML
    yamlls = {},

    -- JSON
    jsonls = {},

    -- C/C++
    clangd = {},
}

-- ============================================================================
-- Mason LSP Setup
-- ============================================================================

-- First setup mason-lspconfig
mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(server_configs),
    automatic_installation = true,
})

-- Then setup each server
for server_name, config in pairs(server_configs) do
    config.on_attach = on_attach
    config.capabilities = capabilities
    lspconfig[server_name].setup(config)
end
