return {
  { "mattn/webapi-vim" },
  { "tpope/vim-rhubarb" },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function ()
      require("octo").setup({ enable_builtin = true })
      vim.cmd([[hi OctoEditable guibg=none]])
    end
  },
  {
    "mattn/vim-gist",
    dependencies = {
      "mattn/webapi-vim",
    },
  }
}
