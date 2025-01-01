return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  -- { "nvim-telescope/telescope-dap.nvim" },
  { "nvim-telescope/telescope-project.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      -- "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-project.nvim",
    }
  }
}
