local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- One of "all",  or a list of languages
    ensure_installed = {
      "lua",
      "ruby",
      "python",
      "graphql",
      "typescript",
      "javascript",
      "tsx",
      "markdown",
      "go",
      "markdown_inline",
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
    indent = {
      enable = true
    },
    endwise = {
      enable = false
    },
    markdown = {
      enable = true
    }
  }
end

return M
