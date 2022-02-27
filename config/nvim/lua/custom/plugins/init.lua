local plugin_settings = require("core.utils").load_config().plugins

local custom_plugins = {
   -- smooth scroll
   {
       "karb94/neoscroll.nvim",
       event = "WinScrolled",
       config = function()
           require("custom.plugins.configs.others").neoscroll()
       end
   },

   -- lsp
   {
      "onsails/lspkind-nvim",
      disable = not plugin_settings.status.lspsignature,
      after = "nvim-lspconfig",
   },

   -- nvim-treesitter extensions
   {
      "p00f/nvim-ts-rainbow",
      event = "BufRead",
   },
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "BufRead",
   },
   {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "BufRead",
   },
   {
      "romgrk/nvim-treesitter-context",
      event = "BufRead",
   },

   -- ai tools
   {
      "tzachar/cmp-tabnine",
      after = "nvim-cmp",
      run="./install.sh",
      requires = "hrsh7th/nvim-cmp",
      config = function()
         require("custom.plugins.configs.others").cmp_tabnine()
      end
   },
   {
      "github/copilot.vim",
   },

}

return custom_plugins
