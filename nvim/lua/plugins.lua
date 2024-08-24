local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      -- the amount in ms that a plugins load time must be over for it to be
      -- included in the profile
      threshold = 1,
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require "notify"
      end,
    }

    -- Colorscheme
    use {
      "tanvirtin/monokai.nvim",
      config = function()
        vim.cmd "colorscheme monokai"
      end,
    }

    -- mini.nvim
    use {
      'echasnovski/mini.nvim',
      config = function()
        require("mini.icons").setup()
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Statusline
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("config.lualine").setup()
      end,
      requires = {
        "nvim-web-devicons",
        "SmiteshP/nvim-navic",
      },
    }
    use {
      "SmiteshP/nvim-navic",
      requires = {
        "neovim/nvim-lspconfig",
      },
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        "RRethy/nvim-treesitter-endwise",
      }
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim", tag = "0.1.8",
      config = function()
        require("config.telescope").setup()
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "nvim-telescope/telescope-project.nvim" },
      }
    }

    -- FZF
    use { "junegunn/fzf", run = "./install --all" }
    use { "junegunn/fzf.vim" }
    use {
      "ibhagwan/fzf-lua",
      event = "BufEnter",
      requires = { "kyazdani42/nvim-web-devicons" },
    }

    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      }
    })


    -- Snippets
    use({
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!:).
      run = "make install_jsregexp",
      config = function()
        require("config.luasnip").setup()
      end,
      requires = {
        "rafamadriz/friendly-snippets" 
      }
    })

    -- LSP
    use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate", -- :MasonUpdate updates registry contents
      config = function()
        require("mason").setup({
          PATH = "append", -- Prioritize system executables if available
        })
      end
    }
    use {
      "williamboman/mason-lspconfig.nvim",
    }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        -- "ms-jpq/coq_nvim",
        "hrsh7th/cmp-nvim-lsp",
        "b0o/schemastore.nvim",
      },
    }
    use {
      "j-hui/fidget.nvim",
      tag = "legacy",
      config = function()
        require("fidget").setup {}
      end,
    }

    -- GraphQL
    use {
      "jparise/vim-graphql"
    }

    -- Terraform
    use {
      "hashivim/vim-terraform",
    }

    -- Git
    use {
      "tpope/vim-fugitive",
    }
    use {
      "tpope/vim-rhubarb",
    }

    -- Github
    use {
      "pwntester/octo.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("octo").setup({ enable_builtin = true })
        vim.cmd([[hi OctoEditable guibg=none]])
      end,
    }

    use {
      "mattn/vim-gist",
      requires = {
        "mattn/webapi-vim",
      },
    }

    -- Helpers
    use {
      "tpope/vim-eunuch"
    }

    -- Testing
    use {
      "nvim-neotest/neotest",
      requires = {
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

    -- DAP
    use {
      "mfussenegger/nvim-dap",
    }
    use {
      "suketa/nvim-dap-ruby",
      requires = {
        "mfussenegger/nvim-dap",
      },
    }
    use {
      "mfussenegger/nvim-dap-python",
      requires = {
        "mfussenegger/nvim-dap",
      },
      config = function()
        require("dap-python").setup()
      end,
    }
    use {
      "mfussenegger/nvim-dap-ui",
      requires = {
        "mfussenegger/nvim-dap",
      },
      config = function()
        require("dapui").setup()
      end,
    }

    -- REPL
    use {
      "Vigemus/iron.nvim",
      config = function()
        require("config.iron").setup()
      end
    }

    -- Rust
    use {
      "rust-lang/rust.vim",
    }

    -- Copliot
    use {
      "github/copilot.vim",
    }

    use({
      "Bryley/neoai.nvim",
      requires = { "MunifTanjim/nui.nvim" },
      cmd = {
        "NeoAI",
        "NeoAIOpen",
        "NeoAIClose",
        "NeoAIToggle",
        "NeoAIContext",
        "NeoAIContextOpen",
        "NeoAIContextClose",
        "NeoAIInject",
        "NeoAIInjectCode",
        "NeoAIInjectContext",
        "NeoAIInjectContextCode",
      },
      config = function()
        require("neoai").setup({
          models = {
            {
              name = "openai",
              model = "gpt-4-turbo", -- gpt-3.5-turbo",
              params = nil,
            },
          },
        })
      end,
    })

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
