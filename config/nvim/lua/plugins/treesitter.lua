-- ============================================================================
-- Treesitter Configuration
-- ============================================================================

require("nvim-treesitter.configs").setup({
    -- ========================================================================
    -- Parsers to Install
    -- ========================================================================

    ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    -- Install parsers synchronously (only applied to ensure_installed)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- ========================================================================
    -- Highlighting
    -- ========================================================================

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    -- ========================================================================
    -- Indentation
    -- ========================================================================

    indent = {
        enable = true,
        disable = { "python" }, -- Python indentation is handled differently
    },

    -- ========================================================================
    -- Incremental Selection
    -- ========================================================================

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",    -- Start selection
            node_incremental = "grn",  -- Expand to node
            scope_incremental = "grc", -- Expand to scope
            node_decremental = "grm",  -- Shrink selection
        },
    },
})
