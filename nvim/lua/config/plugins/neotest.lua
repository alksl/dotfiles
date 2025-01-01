return {
  { "antoinemadec/FixCursorHold.nvim" },
  { "olimorris/neotest-rspec" },
  { "nvim-neotest/neotest-plenary" },
  { "nvim-neotest/neotest-python" },
  { "nvim-neotest/nvim-nio" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-plenary"),
          require("neotest-rspec"),
          require("neotest-python")({
            dap = { justMyCode = false },
            test_command = "pytest",
            test_file_pattern = "test_*.py",
          })
        }
      })
    end
  }
}
