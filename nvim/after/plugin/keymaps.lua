local default_opts = { noremap = true, silent = true }

vim.keymap.set("v", "<C-c>", ":y +<CR>", default_opts)

vim.keymap.set(
  "n",
  "<C-e>",
  "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>",
  default_opts
)
vim.keymap.set(
  "n",
  "<C-p>",
  "<cmd>lua require('telescope').extensions.project.project()<cr>",
  default_opts
)
vim.keymap.set(
  "n",
  "<C-b>",
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  default_opts
)

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

vim.keymap.set('i', '<C-a>', 'copilot#Accept("<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.keymap.set("n", "[q", "<cmd>cprev<cr>", default_opts)
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", default_opts)
vim.keymap.set("n", "<M-j>", "<cmd>cnext<cr>", default_opts)
vim.keymap.set("n", "<M-k>", "<cmd>cprev<cr>", default_opts)

vim.keymap.set("n", "<space><space>x", "<cmd>source %<cr>")
vim.keymap.set("n", "<space>x", ":.lua<cr>")
vim.keymap.set("v", "<space>x", ":lua<cr>")

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

