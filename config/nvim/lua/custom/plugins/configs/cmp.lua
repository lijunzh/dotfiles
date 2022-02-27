local M = {}

local lspkind = require('lspkind')
local source_mapping = {
   buffer = "[Buffer]",
   nvim_lsp = "[LSP]",
   nvim_lua = "[Lua]",
   cmp_tabnine = "[TN]",
   path = "[Path]",
}

M.cmp = {
   formatting = {
      format = function(entry, vim_item)
         vim_item.kind = lspkind.presets.default[vim_item.kind]
         
         local menu = source_mapping[entry.source.name]
         if entry.source.name == 'cmp_tabnine' then
             if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                 menu = entry.completion_item.data.detail .. ' ' .. menu
             end
             vim_item.kind = ''
         end
         vim_item.menu = menu

         return vim_item
      end,
   },

   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
   },

   sources = {
      { name = "cmp_tabnine" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer" },
      { name = 'cmdline' },
   },
}

return M
