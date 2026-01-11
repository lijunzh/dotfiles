-- ============================================================================
-- LSP Configuration
-- ============================================================================

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
-- Setup Mason and Mason-LSPConfig
-- ============================================================================

require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ruff",
        "taplo",
        "texlab",
        "clangd",
    },
    -- Optional servers (install manually via :Mason if needed):
    -- bashls, yamlls, jsonls
    automatic_installation = false,
})

-- ============================================================================
-- LSP Server Configurations
-- ============================================================================

-- Lua
vim.lsp.config("lua_ls", {
    default_config = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
    },
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
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Rust
vim.lsp.config("rust_analyzer", {
    default_config = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml" },
    },
    settings = {
        ["rust-analyzer"] = {
            check = { command = "clippy" },
            cargo = { allFeatures = true },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Python (Ruff)
vim.lsp.config("ruff", {
    default_config = {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Bash
vim.lsp.config("bashls", {
    default_config = {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- TOML
vim.lsp.config("taplo", {
    default_config = {
        cmd = { "taplo", "lsp", "stdio" },
        filetypes = { "toml" },
        root_markers = { ".git" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- LaTeX
vim.lsp.config("texlab", {
    default_config = {
        cmd = { "texlab" },
        filetypes = { "tex", "plaintex", "bib" },
        root_markers = { ".git" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- YAML
vim.lsp.config("yamlls", {
    default_config = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
        root_markers = { ".git" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- JSON
vim.lsp.config("jsonls", {
    default_config = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- C/C++
vim.lsp.config("clangd", {
    default_config = {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Enable all configured servers
vim.lsp.enable({
    "lua_ls",
    "rust_analyzer",
    "ruff",
    "bashls",
    "taplo",
    "texlab",
    "yamlls",
    "jsonls",
    "clangd",
})
