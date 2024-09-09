local M = {}

function M.setup()
  require("mason").setup()
  require("mason-lspconfig").setup {
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "ruby_lsp",
      "jsonls",
      "yamlls",
      "terraformls",
      "tflint",
      "bashls",
      "pyright",
      "ruff_lsp",
      "rubocop",
      "ts_ls",
    }
  }

  local lspconfig = require("lspconfig")
  local navic = require("nvim-navic")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
      end
  end

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig.ts_ls.setup(opts)
  lspconfig.ruby_lsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {"bundle", "exec", "ruby-lsp"},
  })
  lspconfig.rubocop.setup({
    capabilities = capabilities,
    cmd = { "bundle", "exec", "rubocop", "--lsp" },
  })
  lspconfig.terraformls.setup(opts)
  lspconfig.tflint.setup(opts)
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're 
          -- using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  })
  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  })
  lspconfig.bashls.setup(opts)
  lspconfig.pyright.setup(opts)
  lspconfig.ruff_lsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      settings = {
        args = {}
      }
    }
  })
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
      vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
    end,
    settings = {
      ["rust_analyzer"] = {
        imports = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true
          },
        }
      },
    }
  })

  vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*.py", "*.tf", "*.tfvars", "*.rb"},
    callback = function()
      vim.lsp.buf.format()
    end,
  })

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd(
    'LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local key_opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, key_opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, key_opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, key_opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, key_opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, key_opts)
        vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, key_opts)
        vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, key_opts)
        vim.keymap.set('n', '<Leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, key_opts)
        vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, key_opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, key_opts)
        vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, key_opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, key_opts)
        vim.keymap.set('n', '<Leader>f', function()
          vim.lsp.buf.format { async = true }
        end, key_opts)
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, key_opts)
      end,
  })
end

return M
