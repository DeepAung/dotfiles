return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}

      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
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
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }

      local api = require 'Comment.api'
      local toggleNormal = api.toggle.linewise.current
      local toggleVisual = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"

      vim.keymap.set('n', '<leader>/', toggleNormal, { desc = 'Toggle comment' })
      vim.keymap.set('v', '<leader>/', toggleVisual, { desc = 'Toggle comment' })
    end,
  },
  { 'wakatime/vim-wakatime', lazy = false },
  {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      require('competitest').setup {
        run_command = {
          python = { exec = 'python3', args = { '$(FNAME)' } },
        },
      }

      vim.keymap.set('n', '<leader>cpa', ':CompetiTest add_testcase<CR>')
      vim.keymap.set('n', '<leader>cpe', ':CompetiTest edit_testcase<CR>')
      vim.keymap.set('n', '<leader>cpd', ':CompetiTest delete_testcase<CR>')
      vim.keymap.set('n', '<leader>cpr', ':CompetiTest run<CR>')
      vim.keymap.set('n', '<leader>cpx', ':CompetiTest run_no_compile<CR>')
    end,
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
