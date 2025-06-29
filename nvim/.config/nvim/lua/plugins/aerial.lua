return {
  'stevearc/aerial.nvim',
  opts = {
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set('n', '{', ':AerialPrev<CR>', { buffer = bufnr })
      vim.keymap.set('n', '}', ':AerialNext<CR>', { buffer = bufnr })
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
