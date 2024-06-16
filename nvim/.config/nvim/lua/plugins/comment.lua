-- TODO: comment .templ file
return {
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })

      local api = require("Comment.api")
      local toggleNormal = api.toggle.linewise.current
      local toggleVisual = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"

      vim.keymap.set("n", "<C-_>", toggleNormal, { desc = "Toggle comment" })
      vim.keymap.set("v", "<C-_>", toggleVisual, { desc = "Toggle comment" })
      vim.keymap.set("n", "<leader>/", toggleNormal, { desc = "Toggle comment" })
      vim.keymap.set("v", "<leader>/", toggleVisual, { desc = "Toggle comment" })
    end,
  },
}
