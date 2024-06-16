return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      git = {
        enable = true,
        ignore = false,
      },

      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    })

    local api = require("nvim-tree.api")
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = "nvim-tree: " .. desc })
    end

    map("<leader>n", api.tree.toggle, "Toggle")
    -- map("<C-n>", api.tree.toggle, "Toggle")
    map("?", api.tree.toggle_help, "Help")
  end,
}
