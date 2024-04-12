local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("v", "<C-c>", ":y +<CR>", default_opts)

keymap(
  "n",
  "<C-p>",
  "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>",
  default_opts
)
keymap(
  "n",
  "<C-b>",
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  default_opts
)
vim.keymap.set('i', '<C-a>', 'copilot#Accept("<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
