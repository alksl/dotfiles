local M = {}

function M.setup()
  local whichkey = require("which-key")
  whichkey.setup({})
  whichkey.add({
    {"<leader>w", "<cmd>update!<cr>", desc = "Save", mode = "n"},
    {"<leader>d", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc="Diagnostics" },
    {"<leader>s", "<cmd>source ~/dotfiles/nvim/after/plugin/snippets.lua<cr>", desc="Load snippets"},

    {"<leader>b", group = "Buffer"},
    {"<leader>bc", "<cmd>bd!<cr>", desc ="Close current buffer"},
    {"<leader>bD", "<cmd>%bd | e# | bd#<cr>", desc ="Delete all buffers"},

    {"<leader>f", group = "Find"},
    {"<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Files" },
    {"<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Buffers" },
    {"<leader>fg", "<cmd>lua require('utils.multigrep').live_multigrep()<cr>", desc = "Multi Grep" },
    {"<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Help" },

    {"<leader>g", group = "Git"},
    {"<leader>gg", "<cmd>Git<cr>", desc = "Git"},
    {"<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
    {"<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>", desc = "Status" },
    {"<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", desc = "Commits" },
    {"<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", desc = "Branches" },
    {"<leader>gf", "<cmd>lua require('utils.git').git_fixup()<cr>", desc = "Fixup" },

    {"<leader>l", group = "LSP"},
    {"<leader>lr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", desc = "References"},
    {"<leader>ld", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", desc = "Definitions" },
    {"<leader>lt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>", desc = "Type Definitions" },
    {"<leader>li", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", desc = "Implementations" },
    {"<leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", desc = "Document Symbols" },
    {"<leader>lw", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", desc = "Workspace symbols" },

    {"<leader>t", group = "Neotest"},
    {"<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach" },
    {"<leader>tf", "<cmd>w<cr><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run File" },
    {"<leader>tF", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc = "Debug File" },
    {"<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "Run Last" },
    {"<leader>tL", "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", desc = "Debug Last" },
    {"<leader>tn", "<cmd>w<cr><cmd>lua require('neotest').run.run()<cr>", desc = "Run Nearest" },
    {"<leader>tN", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
    {"<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
    {"<leader>tS", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop" },
    {"<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary" },

    {"<leader>O", "<cmd>Octo<cr>"},
    {"<leader>o", group = "Octo"},
    {"<leader>oa",  "<cmd>Octo actions<cr>", desc = "Actions" },
    {"<leader>ol",  "<cmd>Octo pr list<cr>", desc = "PR List" },
    {"<leader>oo",  "<cmd>Octo pr browser<cr>", desc = "Open" },
    {"<leader>oc",  "<cmd>Octo pr checks<cr>", desc = "Checks" },
    {"<leader>os",  "<cmd>Octo pr checkout<cr>", desc = "Checkout" },

    {"<leader>r>", group = "REPL"},
    {"<leader>rs", "<cmd>IronRepl<cr>", desc = "Start" },
    {"<leader>rr", "<cmd>IronRestart<cr>", desc = "Restart" },
    {"<leader>rf", "<cmd>IronFocus<cr>", desc = "Focus" },
    {"<leader>rh", "<cmd>IronHide<cr>", desc = "Hide" },

    {"<leader>c", group = "Chat"},
    {"<leader>cn", "<cmd>PrtChatNew<cr>", desc = "New", mode = "n" },
    {"<leader>cs", "<cmd>PrtChatRespond<cr>", desc = "Trigger Response", mode = "n" },
    {"<leader>ct", "<cmd>PrtChatToggle<cr>", desc = "Toggle", mode = "n" },
    {"<leader>cd", "<cmd>PrtChatDelete<cr>", desc = "Delete", mode = "n" },
    {"<leader>cf", "<cmd>PrtChatFinder<cr>", desc = "Find", mode = "n" },
    {"<leader>cp", "<cmd>PrtProvider<cr>", desc = "Provider", mode = "n" },
    {"<leader>cr", "<cmd>'<,'>PrtRewrite<cr>", desc = "Rewrite", mode = "v" },
    {"<leader>ci", "<cmd>'<,'>PrtImplement<cr>", desc = "Implement", mode = "v" },
    {"<leader>ca", "<cmd>'<,'>PrtAppend<cr>", desc = "Append", mode = "v" },
    {"<leader>ce", "<cmd>'<,'>PrtEdit<cr>", desc = "Edit", mode = "v" },
    {"<leader>cp", "<cmd>'<,'>PrtChatPaste<cr>", desc = "Paste", mode = "v" },
  })
end

return M
