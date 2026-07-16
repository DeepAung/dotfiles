return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    ---@type table<string, vim.lsp.Config>
    local servers = {
      dockerls = {},
      basedpyright = {},
      -- jedi_language_server = {},
      cssls = {},
      tailwindcss = {},
      templ = {},
      tsgo = {
        cmd = { 'tsgo', '--lsp', '--stdio' },
        -- Ensure it roots at the global monorepo level
        root_dir = vim.fs.root(0, { 'pnpm-workspace.yaml', 'turbo.json', 'nx.json', 'package.json', '.git' }),
      },
      eslint = {},
      svelte = {},
      buf = {},
      graphql = {},
      clangd = {
        cmd = { 'clangd', '--offset-encoding=utf-16', '--header-insertion=never', '--query-driver=/usr/bin/gcc' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      },
      emmet_ls = {
        filetypes = { 'html', 'templ' },
      },
      html = {
        filetypes = { 'html', 'templ' },
      },
      lua_ls = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              --  See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                '${3rd}/luv/library',
                '${3rd}/busted/library',
              }),
            },
          })
        end,
        settings = {
          Lua = {},
        },
      },
      gopls = {},
      verible = {
        cmd = {
          'verible-verilog-ls',
          '--rules=-always-comb,-unpacked-dimensions-range-ordering,-explicit-parameter-storage-type',
          '--file_list_path=verible.filelist',
          '--indentation_spaces=4',
        },
      },
      postgres_lsp = {},
      yamlls = {
        filetypes = { 'yaml', 'yml', 'yaml.docker-compose', 'yaml.gitlab' },
        settings = {
          yaml = {
            -- format = { enable = true },
            kubernetesCRDStore = { enable = true },
            -- schemas = {
            --   kubernetes = '*.yaml',
            -- },
          },
        },
      },
      helm_ls = {
        filetypes = { 'helm', 'helmfile', 'yaml.helm', 'yaml.helm-values' },
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = 'yaml-language-server',
            },
          },
        },
      },
      tilt_ls = {},
      taplo = {},
      marksman = {},
      terraformls = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})

    ensure_installed = vim.tbl_filter(function(key)
      return key ~= 'tilt_ls'
    end, ensure_installed)

    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
      'prettier',
      'clang-format',
      'gofumpt',
      'goimports',
      'golines',
      'black',
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
}
