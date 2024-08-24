local M = {}

function M.setup()
  local cmp = require("cmp")
  cmp.setup({
    sources = cmp.config.sources({
      { name = "nvim_lsp"},
      { name = "luasnip" },
      { name = "path" },
      { name = "cmdline" },
      { name = "buffer", keyword_length = 5}
    }),
   mapping = cmp.mapping.preset.insert({
      ['<c-b>'] = cmp.mapping.scroll_docs(-4),
      ['<c-f>'] = cmp.mapping.scroll_docs(4),
      ['<c-space>'] = cmp.mapping.complete(),
      ['<c-e>'] = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<c-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }
  })
end

return M
