local plugin_settings = require("core.utils").load_config().plugins

local custom_plugins = {
   -- autosave
   {
      "Pocco81/AutoSave.nvim",
      config = function()
         local autosave = require "autosave"
   
         autosave.setup {
            enabled = true,
            execution_message = "autosaved at : " .. vim.fn.strftime "%H:%M:%S",
            events = { "FocusLost", "InsertLeave", "TextChanged" },
            conditions = {
               exists = true,
               filetype_is_not = {},
               modifiable = true,
            },
            clean_command_line_interval = 2500,
            on_off_commands = true,
            write_all_buffers = false,
         }
      end,
   },

   -- smooth scroll
   {
      "karb94/neoscroll.nvim",
      opt = true,
      config = function()
         require("neoscroll").setup()
      end,

      -- lazy loading
      setup = function()
        require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   },

   {
      "luukvbaal/stabilize.nvim",
      config = function() 
         require("stabilize").setup() 
      end,
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
      "github/copilot.vim",
      event = "InsertEnter",
      config = function()
         require("custom.plugins.configs.others").copilot()
      end,
   },

   -- utils
   {
      "folke/which-key.nvim",
      config = function() require("which-key").setup {} end
   },
   {
      "KenN7/vim-arsync",
      cmd = {
          "ARsyncUp", "ARsyncConf", "ARsyncDown", "ARsyncUpDelete",
      },
   },
}

return custom_plugins
