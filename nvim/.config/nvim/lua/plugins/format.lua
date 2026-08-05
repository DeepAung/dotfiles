local oxc = require('config.oxc')

local function web_formatter(bufnr)
  if oxc.has_oxfmt_config(bufnr) then
    return { 'oxfmt' }
  end
  if oxc.is_deno_project(bufnr) then
    return { 'deno_fmt' }
  end
  return { 'prettier' }
end

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
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_after_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      end

      return {
        lsp_format = 'fallback',
      }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },

      javascript = web_formatter,
      javascriptreact = web_formatter,
      typescript = web_formatter,
      typescriptreact = web_formatter,
      svelte = web_formatter,
      json = web_formatter,
      html = web_formatter,
      css = web_formatter,

      c = { 'clang_format' },
      cpp = { 'clang_format' },

      python = { 'black' },

      go = { 'gofumpt', 'goimports' },

      verilog = { 'verible' },
      systemverilog = { 'verible' },
    },

    formatters = {
      -- golines = {
      --   prepend_args = { '--max-len=1000' },
      -- },
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
