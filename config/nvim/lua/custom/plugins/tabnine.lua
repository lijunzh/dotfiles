local tabnine = require("cmp_tabnine.config")

local default = {
   max_lines = 1000,
   max_num_results = 20,
   sort = true,
   run_on_every_keystroke = true,
   snippet_placeholder = "..",
}

local M = {}

M.setup = function()
	tabnine:setup(default)
end

return M
