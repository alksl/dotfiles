return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "tadmccorkle/markdown.nvim",
    },
    config = function()
      require("config.treesitter").setup()
    end,
  }
}
