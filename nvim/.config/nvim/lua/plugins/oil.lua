return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup({
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set('n', '-', ':Oil<cr>', { desc = 'Oil: open parent directory' })
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  lazy = false,
}
