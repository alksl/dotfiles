local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = ","
g.maplocalleader = ","

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true -- Set highlight on search
opt.number = true -- Make line numbers default
opt.undofile = true --Save undo history
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.expandtab = true
opt.tw = 79

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
