return {
  { 'NMAC427/guess-indent.nvim', opts = {} },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })

      local api = require('Comment.api')
      local toggleNormal = api.toggle.linewise.current
      local toggleVisual = "<ESC>:lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"

      vim.keymap.set('n', '<leader>/', toggleNormal, { desc = 'Toggle comment' })
      vim.keymap.set('v', '<leader>/', toggleVisual, { desc = 'Toggle comment' })
    end,
  },
  { 'wakatime/vim-wakatime', lazy = false },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.surround').setup()
      require('mini.pairs').setup()

      local statusline = require('mini.statusline')
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup({
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
  { 'qvalentin/helm-ls.nvim', ft = 'helm' },
}
