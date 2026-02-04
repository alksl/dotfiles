local M = {}

function M.setup()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local builtin = require('telescope.builtin')
  local actions_state = require('telescope.actions.state')

  local find_files_without_cwd = function(prompt_bufnr, hidden_files)
    local project_path = actions_state.get_selected_entry(prompt_bufnr).value
    actions._close(prompt_bufnr, true)
    vim.schedule(function()
      builtin.find_files({cwd = project_path, hidden = hidden_files})
    end)
  end

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
          {"~/code", max_depth = 3},
        },
        hidden_files = true, -- default: false
        theme = "dropdown",
        order_by = "asc",
        search_by = "title",
        mappings = {
          n = {
            ["f"] = find_files_without_cwd,
          }
        },
        sync_with_nvim_tree = true, -- default false
        -- default for on_project_selected = find project files
        -- on_project_selected = function(prompt_bufnr)
        --   -- Do anything you want in here. For example:
        --   -- project_actions.change_working_directory(prompt_bufnr, false)
        -- end
      }
    }
  })
end

return M
