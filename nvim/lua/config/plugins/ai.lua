return {
  { "github/copilot.vim" },
  { "frankroeder/parrot.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
    },
    config = function()
      require("config.parrot").setup()
    end,
  },
}
