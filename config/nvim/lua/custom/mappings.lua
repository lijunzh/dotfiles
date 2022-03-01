local map = require("core.utils").map

-- misc
map("n", "<leader>q", ":q <CR>")

-- packer
map("n", "<C-p>c", ":PackerClean <CR>")
map("n", "<C-p>s", ":PackerSync <CR>")

-- always have mappings for formatting code
map("n", "<leader>fm", ":lua vim.lsp.buf.formatting()<CR>")
