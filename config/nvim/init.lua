-- ============================================================================
-- Neovim Configuration
-- ============================================================================
-- Pure Lua config without frameworks
-- Structure:
--   lua/core/options.lua   - Vim options
--   lua/core/keymaps.lua   - Keybindings
--   lua/core/autocmds.lua  - Autocommands
--   lua/plugins/init.lua   - Plugin specifications
--   lua/plugins/lsp.lua    - LSP configuration
--   lua/plugins/treesitter.lua - Treesitter configuration

-- ============================================================================
-- Leader Key (must be set before plugins)
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Load Core Configuration
-- ============================================================================

require("core.options")
require("core.keymaps")
require("core.autocmds")

-- ============================================================================
-- Load Plugins
-- ============================================================================

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "gruvbox" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
