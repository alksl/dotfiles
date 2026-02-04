return {
  { "github/copilot.vim" },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
      strategies = {
        chat = {
          adapter = {
            name = "opencode",
            model = "claude-sonnet-4.4",
          },
        },
      },
    },
  },
}
