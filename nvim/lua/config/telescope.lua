local M = {}

function M.setup()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local project_actions = require("telescope._extensions.project.actions")
  telescope.setup({
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
    extensions = {
      project = {
        base_dirs = {
          "~/dotfiles",
          {"~/code", max_depth = 3},
        },
        hidden_files = true, -- default: false
        theme = "dropdown",
        order_by = "asc",
        search_by = "title",
        sync_with_nvim_tree = true, -- default false
        -- default for on_project_selected = find project files
        on_project_selected = function(prompt_bufnr)
          -- Do anything you want in here. For example:
          project_actions.change_working_directory(prompt_bufnr, false)
        end
      }
    }
  })
  telescope.load_extension("dap")
  telescope.load_extension("project")
end

return M
