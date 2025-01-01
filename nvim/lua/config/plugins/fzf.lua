return {
  { "junegunn/fzf", build = "./install --all" },
  { "junegunn/fzf.vim" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "kyazdani42/nvim-web-devicons" }
  }
}
