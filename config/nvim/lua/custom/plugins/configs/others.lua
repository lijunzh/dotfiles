local M = {}

M.autosave = function(override_flag)
   local present, autosave = pcall(require, "autosave")
   if present then
      local default = {
          enabled = true,
          execution_message = "autosaved at : " .. vim.fn.strftime("%H:%M:%S"),
          events = {"FocusLost"},
          conditions = {
              exists = true,
              filetype_is_not = {},
              modifiable = true
          },
          write_all_buffers = false,
          on_off_commands = true,
          clean_command_line_interval = 2500
      }
      autosave.setup(default)
   end
end

M.neoscroll = function()
   pcall(
      function()
         require("neoscroll").setup()
      end
   )
end

M.copilot = function()
   vim.cmd [[
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
      let g:copilot_no_tab_map = v:true
   ]]
end

M.nvimtree = {
   git = {
      enable = true,
   },
}

return M
