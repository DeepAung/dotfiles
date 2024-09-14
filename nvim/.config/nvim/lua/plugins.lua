return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
  },
  { 'wakatime/vim-wakatime', lazy = false },
  {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      require('competitest').setup()

      vim.keymap.set('n', '<leader>cpa', ':CompetiTest add_testcase<CR>')
      vim.keymap.set('n', '<leader>cpe', ':CompetiTest edit_testcase<CR>')
      vim.keymap.set('n', '<leader>cpd', ':CompetiTest delete_testcase<CR>')
      vim.keymap.set('n', '<leader>cpr', ':CompetiTest run<CR>')
      vim.keymap.set('n', '<leader>cpx', ':CompetiTest run_no_compile<CR>')
    end,
  },
  -- {
  --   'girishji/pythondoc.vim',
  -- },
}
