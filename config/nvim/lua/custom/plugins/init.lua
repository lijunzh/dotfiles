local custom_plugins = {
   -- smooth scroll
   {
       "karb94/neoscroll.nvim",
       event = "WinScrolled",
       config = function()
           require("custom.plugins.configs.others").neoscroll()
       end
   },
}

return custom_plugins
