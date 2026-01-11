-- ============================================================================
-- Neovim Configuration
-- ============================================================================
-- Pure Lua config - simplified structure
--   init.lua        - Entry point + options
--   lua/keymaps.lua - Keybindings
--   lua/autocmds.lua - Autocommands
--   lua/plugins.lua - Plugin specifications + LSP

-- ============================================================================
-- Leader Key (must be set before plugins)
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Options
-- ============================================================================

local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

-- Tabs and indentation
opt.tabstop = 8
opt.shiftwidth = 8
opt.softtabstop = 8
opt.expandtab = false

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Backspace behavior
opt.backspace = ""

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Appearance
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false
opt.showmatch = true

-- Line wrapping
opt.wrap = false
opt.linebreak = true
opt.showbreak = "↪"

-- Whitespace characters
opt.list = true
opt.listchars = {
    tab = "→ ",
    eol = "¬",
    trail = "⋅",
    extends = "❯",
    precedes = "❮",
    space = "·",
}

-- Text width
opt.textwidth = 79
opt.colorcolumn = "+1"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- Statusline (minimal native)
opt.laststatus = 2
opt.statusline = " %f %m%r%h%w%=%y [%l/%L, %c] "

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
-- Load Modules
-- ============================================================================

require("keymaps")
require("autocmds")

-- ============================================================================
-- Load Plugins
-- ============================================================================

require("lazy").setup("plugins", {
    defaults = { lazy = true },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = true },
    change_detection = { notify = false },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
