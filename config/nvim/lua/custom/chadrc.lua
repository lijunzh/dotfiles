local M = {}

local override = require "custom.plugins.override"
local userPlugins = require "custom.plugins"
local userOptions = require "custom.options"

M.plugins = {

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },

      statusline = {
         separator_style = "round",
      },
   },

   override = {
      ["hrsh7th/nvim-cmp"] = override.cmp,
      ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
      ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
   },

   user = userPlugins,
}

M.ui = {
   theme = "gruvchad",
}

M.options = {
   user = uerOptions,
}

M.mappings = {
   misc = function()
      local map = require("core.utils").map
      map("n", "<leader>w", "<cmd>:w<CR>")
      map("n", "<leader>k", "<cmd>:q<CR>")
   end,
}
return M
