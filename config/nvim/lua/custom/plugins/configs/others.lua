M = {}

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

M.tabnine = function(override_flag)
   local present, tabnine = pcall(require, "cmp_tabnine.config")
   if present then
      local default = {
         max_lines = 1000;
         max_num_results = 20;
         sort = true;
         run_on_every_keystroke = true;
         snippet_placeholder = '..';
      }
      if override_flag then
         default = require("core.utils").tbl_override_req("tabnine", default)
      end
      tabnine:setup(default)
   end
end

M.nvimtree = {
   git = {
      enable = true,
   },
}

return M
