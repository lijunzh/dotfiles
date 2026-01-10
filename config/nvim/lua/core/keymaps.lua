-- ============================================================================
-- Keymaps
-- ============================================================================

local map = vim.keymap.set

-- ============================================================================
-- General
-- ============================================================================

-- Better command mode entry
map("n", ";", ":", { desc = "Enter command mode" })

-- Exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Save and quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader>k", "<cmd>q<cr>", { desc = "Close window" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Clear search highlight
map("n", "<ESC>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- ============================================================================
-- Navigation
-- ============================================================================

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- ============================================================================
-- Editing
-- ============================================================================

-- Move lines up/down
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Don't yank on paste in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- ============================================================================
-- Plugins
-- ============================================================================

-- lazy.nvim
map("n", "<C-s>", "<cmd>Lazy sync<cr>", { desc = "Update plugins" })

-- Format (conform)
map("n", "<leader>fm", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- LSP keymaps (set in lsp.lua on_attach, but define leader maps here)
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to definition" })
map("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references" })
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to implementation" })
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
