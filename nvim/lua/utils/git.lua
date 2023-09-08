local M = {}
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

function M.git_fixup()
  builtin.git_commits {
    attach_mappings = function(_, map)
      map("i", "<cr>", function(bufnr)
        actions.close(bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd([[Git commit --fixup=]] .. selection.value)
      end)
      return true
    end
  }
end

return M
