M = {}

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


return M
