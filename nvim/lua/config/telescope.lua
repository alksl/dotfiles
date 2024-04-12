local M = {}

function M.setup()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-s>"] = actions.select_horizontal,
        }
      },
      file_ignore_patterns = { ".git/" }
    },
  }
  telescope.load_extension("dap")
end

return M
