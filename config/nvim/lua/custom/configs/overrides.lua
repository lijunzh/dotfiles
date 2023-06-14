local M = {}

M.treesitter = {
  ensure_installed = {
		"bash",
    "c",
    "css",
    "html",
    "javascript",
		"json",
    "lua",
    "markdown",
    "markdown_inline",
		"python",
		"rust",
		"toml",
    "tsx",
    "typescript",
    "vim",
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

		-- python
		"pyright",
		"black",
		"isort",

		-- rust
		"rust-analyzer",

		-- shell
		"bash-language-server",
		"shfmt",
		"shellcheck",

		-- latex
		"texlab",

		-- yaml
		"yaml-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
