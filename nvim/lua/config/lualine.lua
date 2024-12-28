local M = {}

local function parrot_status()
  local status_info = require("parrot.config").get_status_info()
  local status = ""
  if status_info.is_chat then
    status = status_info.prov.chat.name
  else
    status = status_info.prov.command.name
  end
  return string.format("%s(%s)", status, status_info.model)
end

function M.setup()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          path = 1,
        },
        {
          "navic",
          color_correction = "static",
          navic_opts = {
            mode = "short",
            color = "auto",
          },
        },
      },
      lualine_x = { parrot_status, "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  })
end

return M
