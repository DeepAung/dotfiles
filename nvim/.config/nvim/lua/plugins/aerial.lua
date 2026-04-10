return {
  'stevearc/aerial.nvim',
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set('n', '[a', ':AerialPrev<CR>', { buffer = bufnr, desc = 'Go to previous [A]erial' })
      vim.keymap.set('n', ']a', ':AerialNext<CR>', { buffer = bufnr, desc = 'Go to next [A]erial' })
    end,
  },
  keys = {
    { '<leader>cs', ':AerialToggle!<CR>', desc = 'Aerial Toggle' },
  },
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
