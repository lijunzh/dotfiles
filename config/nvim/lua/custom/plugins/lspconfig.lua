local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require("lspconfig")

   -- python
   -- lsp: pyright, format: black, isort
   lspconfig.pyright.setup {
      on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formating = false,
         vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fm", ":lua vim.lsp.buf.formatting()<CR>", {})
      end,
   }
end

return M
