-- ============================================================================
-- Plugin Specifications
-- ============================================================================
-- All plugins managed by lazy.nvim

return {
    -- ========================================================================
    -- Colorscheme
    -- ========================================================================

    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                italic = {
                    strings = false,
                    comments = true,
                    operators = false,
                },
            })
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    -- ========================================================================
    -- Telescope (Fuzzy Finder)
    -- ========================================================================

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",           desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",            desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",              desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",            desc = "Help tags" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>",             desc = "Recent files" },
            { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>",      desc = "LSP definitions" },
            { "<leader>lr", "<cmd>Telescope lsp_references<cr>",       desc = "LSP references" },
            { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP symbols" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    path_display = { "truncate" },
                    file_ignore_patterns = { "node_modules", ".git/" },
                },
                pickers = {
                    find_files = { hidden = true },
                },
            })
            telescope.load_extension("fzf")
        end,
    },

    -- ========================================================================
    -- Treesitter (Syntax Highlighting)
    -- ========================================================================

    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        event = { "BufReadPre", "BufNewFile" },
        priority = 500,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash", "c", "css", "html", "json", "lua",
                "markdown", "markdown_inline", "python",
                "rust", "toml", "vim", "vimdoc", "yaml",
            },
            highlight = { enable = true, use_languagetree = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- ========================================================================
    -- Mason (LSP/Tool Installer)
    -- ========================================================================

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        config = function()
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
        end,
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- LSPs
                    "lua_ls",
                    "rust_analyzer",
                    "ruff",
                    "bashls",
                    "taplo",
                    "texlab",
                    "yamlls",
                    "jsonls",
                    "clangd",
                    -- Formatters
                    "stylua",
                    "shfmt",
                    "yamlfmt",
                    "prettier",
                    "deno",
                },
            })
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = true,
            })
        end,
    },

    -- ========================================================================
    -- LSP Configuration
    -- ========================================================================

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = { prefix = "●", spacing = 4 },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = "rounded", source = "always" },
            })

            -- LSP keymaps via LspAttach autocmd (Neovim 0.11+ native approach)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(ev)
                    local bufnr = ev.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end
                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gr", vim.lsp.buf.references, "Go to references")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
                    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
                    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                end,
            })

            -- Server configurations using vim.lsp.config (Neovim 0.11+ native API)
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        check = { command = "clippy" },
                        cargo = { allFeatures = true },
                    },
                },
            })

            -- Simple servers with default config
            local simple_servers = { "ruff", "bashls", "taplo", "texlab", "yamlls", "jsonls", "clangd" }
            for _, server in ipairs(simple_servers) do
                vim.lsp.config(server, {})
            end

            -- Enable all configured servers
            vim.lsp.enable({
                "lua_ls", "rust_analyzer", "ruff", "bashls",
                "taplo", "texlab", "yamlls", "jsonls", "clangd",
            })
        end,
    },

    -- ========================================================================
    -- Conform (Formatting)
    -- ========================================================================

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                desc = "Format buffer",
            },
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format" },
                    rust = { "rustfmt" },
                    sh = { "shfmt" },
                    markdown = { "deno_fmt" },
                    yaml = { "yamlfmt" },
                    json = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                },
            })
        end,
    },

    -- ========================================================================
    -- Git Integration
    -- ========================================================================

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
            })
        end,
    },

    -- ========================================================================
    -- Status Line
    -- ========================================================================

    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "gruvbox",
                    component_separators = "|",
                    section_separators = "",
                },
            })
        end,
    },
}
