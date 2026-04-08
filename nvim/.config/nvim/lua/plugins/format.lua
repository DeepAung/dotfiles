return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    -- notify_on_error = false,
    format_on_save = function(bufnr)
      if require('utils').ignore_format_on_save(vim.bo[bufnr].filetype) then
        return nil
      else
        return {
          timeout_ms = 1000,
          lsp_format = 'fallback',
        }
      end
    end,

    formatters_by_ft = {
      lua = { 'stylua' },

      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      svelte = { 'prettier' },
      json = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },

      c = { 'clang_format' },
      cpp = { 'clang_format' },

      python = { 'black' },

      go = { 'gofumpt', 'goimports', 'golines' },

      verilog = { 'verible' },
      systemverilog = { 'verible' },
    },

    formatters = {
      golines = {
        prepend_args = { '--max-len=200' },
      },
      verible = {
        prepend_args = {
          '--indentation_spaces=4',
          '--case_items_alignment=align',
          '--assignment_statement_alignment=align',
          '--class_member_variable_alignment=align',
          '--distribution_items_alignment=align',
          '--enum_assignment_statement_alignment=align',
          '--formal_parameters_alignment=align',
          '--module_net_variable_alignment=align',
          '--named_parameter_alignment=align',
          '--named_port_alignment=align',
          '--port_declarations_alignment=align',
          '--struct_union_members_alignment=align',
        },
      },
    },
  },
}
