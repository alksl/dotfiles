local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("n", "<C-A>", "<Home>", default_opts)
keymap("i", "<C-A>", "<Home>", default_opts)
keymap("v", "<C-A>", "<Home>", default_opts)

keymap("n", "<C-E>", "<End>", default_opts)
keymap("i", "<C-E>", "<End>", default_opts)
keymap("v", "<C-E>", "<End>", default_opts)

keymap("v", "<C-c>", ":y +<CR>", default_opts)

keymap("n", "<C-p>", ":FzfLua files<CR>", default_opts)
keymap("n", "<C-b>", ":FzfLua buffers<CR>", default_opts)
keymap("n", "<Leader>gs", ":Git<CR>", default_opts)
