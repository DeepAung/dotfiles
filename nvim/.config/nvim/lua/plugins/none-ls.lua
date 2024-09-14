return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,

        null_ls.builtins.formatting.prettier,

        null_ls.builtins.formatting.clang_format,

        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.golines,

        null_ls.builtins.formatting.black,
      },

      on_attach = function(client, bufnr)
        local custom_format = require('utils').custom_format
        vim.keymap.set('n', '<leader>lf', custom_format, { desc = 'format current file' })

        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = custom_format,
          })
        end
      end,
    }
  end,
}
