return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    config = function()
      require("config.treesitter").setup()
    end,
  }
}
