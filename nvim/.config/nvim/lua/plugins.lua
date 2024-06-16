return {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
  },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {},
    lazy = false,
  },
}
