local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    w = { "<cmd>update!<CR>", "Save" },
    q = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    f = {
      name = "Find",
      f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
      b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
      g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep" },
      h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
    },

    g = {
      name = "Git",
      g = { "<cmd>Git<cr>", "Git" },
      p = { "<cmd>Git push <cr>", "Git push" },
      s = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "Status" },
      c = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Commits" },
      b = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Branches" },
      f = { "<cmd>lua require('utils.git').git_fixup()<cr>", "Fixup" },
    },

    d = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "Diagnostics" },

    c  = {
      name = "Quickfix",
      n = { "<cmd>cnext<cr>", "Next" },
      p = { "<cmd>cprev<cr>", "Prev" },
      o = { "<cmd>copen<cr>", "Close" },
      c = { "<cmd>cclose<cr>", "Open" },
    },

    l = {
      name = "LSP",
      r = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "References" },
      d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", "Definitions" },
      t = { "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>", "Type Definitions" },
      i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", "Implementations" },
      s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Document Symbols" },
      w = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", "Workspace symbols" },
    },

    t = {
      name = "Neotest",
      a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
      f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
      F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
      l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
      L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
      n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
      N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
      o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
      S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
      s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
    },

    r = {
      name = "REPL",
      s = { "<cmd>IronRepl<cr>", "Start" },
      r = { "<cmd>IronRestart<cr>", "Restart" },
      f = { "<cmd>IronFocus<cr>", "Focus" },
      h = { "<cmd>IronHide<cr>", "Hide" }
    }
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
