require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<leader>w", "<cmd> w <cr>", { desc = "Save buffer" })
map({ "n", "i", "v" }, "<leader>k", "<cmd> q <cr>", { desc = "Close window" })

map({ "n" }, "<C-s>", "<cmd>  Lazy sync <cr>", { desc = "Update plugins" })

map("n", "<leader>fm", function()
	require("conform").format()
end, { desc = "File Format with conform" })
