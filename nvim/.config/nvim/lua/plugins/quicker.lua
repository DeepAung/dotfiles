return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  config = function()
    local quicker = require('quicker')

    vim.keymap.set('n', '<leader>q', function()
      quicker.toggle()
    end, { desc = 'Toggle [Q]uickfix list' })
    vim.keymap.set('n', '<leader>l', function()
      quicker.toggle({ loclist = true })
    end, { desc = 'Toggle [L]oclist' })

    quicker.setup()
  end,
}
