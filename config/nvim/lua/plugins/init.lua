-- ============================================================================
-- Plugin Specifications
-- ============================================================================
-- All plugins are managed by lazy.nvim
-- Plugins are lazy-loaded by default

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
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>",   desc = "Recent files" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
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
                    find_files = {
                        hidden = true,
                    },
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
        branch = "main",
        lazy = false,
        priority = 500,
        build = ":TSUpdate",
        config = function()
            -- New nvim-treesitter main branch API
            -- Auto-install parsers
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })

            -- Install parsers for common languages
            local parsers = {
                "bash", "c", "css", "html", "json", "lua",
                "markdown", "markdown_inline", "python",
                "rust", "toml", "vim", "vimdoc", "yaml",
            }

            -- Install parsers if not already installed
            for _, parser in ipairs(parsers) do
                local ok, _ = pcall(vim.treesitter.language.inspect, parser)
                if not ok then
                    pcall(vim.cmd, "TSInstall " .. parser)
                end
            end
        end,
    },

    -- ========================================================================
    -- Mason & LSP (loaded together)
    -- ========================================================================

    {
        "williamboman/mason.nvim",
        lazy = false,
        priority = 1000,
        build = ":MasonUpdate",
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        priority = 999,
        dependencies = {
            "williamboman/mason.nvim",
        },
    },

    {
        "neovim/nvim-lspconfig",
        lazy = false,
        priority = 998,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("plugins.lsp")
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
                -- Uncomment to enable format on save
                -- format_on_save = {
                --     timeout_ms = 500,
                --     lsp_fallback = true,
                -- },
            })
        end,
    },

    -- ========================================================================
    -- Completion (Optional - minimal setup)
    -- ========================================================================

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}
