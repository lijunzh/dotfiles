-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/

local custom_modules = {
	"custom.options",
	"custom.autocmds",
	"custom.mappings",
}

for _, module in ipairs(custom_modules) do
	local ok, err = pcall(require, module)
	if not ok then
		vim.notify("Error loading cutom module" .. module .. "\n\n" .. err)
	end
end
