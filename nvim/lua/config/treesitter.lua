local M = {}

local parsers = {
  "lua",
  "ruby",
  "python",
  "graphql",
  "typescript",
  "javascript",
  "tsx",
  "markdown",
  "markdown_inline",
  "go",
}

function M.setup()
  require("nvim-treesitter").setup()
  require("nvim-treesitter").install(parsers)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = parsers,
    callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
