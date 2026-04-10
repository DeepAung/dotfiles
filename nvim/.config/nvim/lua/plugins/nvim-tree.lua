return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup({
      filters = {
        git_ignored = false,
      },
      renderer = {
        highlight_git = 'name',
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        api.map.on_attach.default(bufnr)

        vim.keymap.set('n', '?', api.tree.toggle_help, { desc = 'nvim-tree: Help', buffer = bufnr, noremap = true, silent = true, nowait = true })
      end,
    })

    vim.keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle, { desc = 'nvim-tree: Toggle' })
  end,
}
