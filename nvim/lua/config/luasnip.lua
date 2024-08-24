local M = {}

function M.setup()
  local ls = require('luasnip')

  ls.config.set_config({
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
  })

  vim.keymap.set(
    {"i", "s"},
    "<c-s>",
    function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end,
    {silent = true}
  )
  vim.keymap.set(
    {"i", "s"},
    "<c-l>",
    function()
      ls.jump( 1)
    end,
    {silent = true}
  )
  vim.keymap.set(
    {"i", "s"},
    "<c-j>",
    function()
      ls.jump(-1)
    end,
    {silent = true}
  )

  vim.keymap.set(
    {"i", "s"},
    "<c-e>",
    function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end,
    {silent = true}
  )

  vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/dotfiles/nvim/after/plugin/snippets.lua<cr>")
end

return M
