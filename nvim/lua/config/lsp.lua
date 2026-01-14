local M = {}

function M.setup()
  require("mason").setup()
  require("mason-lspconfig").setup {
    automatic_enable = {
      "tofu_ls",
    },
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "ruby_lsp",
      "jsonls",
      "yamlls",
      "bashls",
      "pyright",
      "ruff",
      "rubocop",
      "denols",
      "tofu_ls",
      "gopls",
    }
  }

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

  -- Add these helper functions after line 26
  local function find_project_root(fname, markers)
    local path = vim.fn.fnamemodify(fname, ':p:h')
    while path ~= '/' do
      for _, marker in ipairs(markers) do
        if vim.loop.fs_stat(path .. '/' .. marker)
        then
          return path
        end
      end
      path = vim.fn.fnamemodify(path, ':h')
    end
    return nil
  end

  local function has_deno_config(fname)
    return find_project_root(fname, {'deno.json',
      'deno.jsonc'}) ~= nil
  end

  local function has_package_json(fname)
    return find_project_root(fname, {'package.json'})
      ~= nil
  end

  vim.lsp.config('gopls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
        staticcheck = true,
      }
    }
  })
  vim.lsp.enable('gopls')
  vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)

      if has_package_json(fname) and not has_deno_config(fname) then
        local root = find_project_root(fname, {'package.json'})
        if root then
          on_dir(root)
        end
      end
      -- Don't call on_dir() to skip activation
    end
  })
  vim.lsp.enable('ts_ls')
  vim.lsp.config('denols', {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)

      -- Start denols if there's a deno config
      local deno_root = find_project_root(fname, {'deno.json', 'deno.jsonc'})
      if deno_root then
        on_dir(deno_root)
        return
      end

      -- For single files without package.json, use file directory
      if not has_package_json(fname) then
        on_dir(vim.fn.fnamemodify(fname, ':p:h'))
        return
      end
      -- Don't call on_dir() to skip activation
    end,
  })
  vim.lsp.enable('denols')
  vim.lsp.config('ruby_lsp', {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "bundle", "exec", "ruby-lsp" },
  })
  vim.lsp.enable('ruby_lsp')
  -- vim.lsp.config('rubocop', {
  --   capabilities = capabilities,
  --   cmd = { "bundle", "exec", "rubocop", "--lsp" },
  -- -- })
  -- vim.lsp.enable('ruby_lsp')
  -- vim.lsp.config('terraformls', opts)
  -- viml.lsp.enable('terraformls')
  vim.lsp.config("tofu_ls", opts)
  -- vim.lsp.config('tflint', opts)
  -- vim.lsp.enable('tflint')
  vim.lsp.config('lua_ls',{
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
          globals = { 'vim' },
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
  vim.lsp.enable('lua_ls')

  vim.lsp.config('jsonls', {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  })
  vim.lsp.enable('jsonls')
  vim.lsp.config('yamlls', {
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
  vim.lsp.enable('yamlls')
  vim.lsp.config('bashls', opts)
  vim.lsp.enable('bashls')
  vim.lsp.config('pyright', opts)
  vim.lsp.enable('pyright')
  vim.lsp.config('ruff', {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      settings = {
        args = {}
      }
    }
  })
  vim.lsp.enable('ruff')
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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
  vim.lsp.enable('rust_analyzer')

  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.py", "*.tf", "*.tfvars", "*.rb", "*.ts" },
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
        vim.keymap.set({ 'n', 'v' }, '<Leader>la', vim.lsp.buf.code_action, key_opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, key_opts)
        vim.keymap.set('n', '<Leader>f', function()
          vim.lsp.buf.format { async = true }
        end, key_opts)
        vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, key_opts)
      end,
    })
end

return M
