return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<C-h>',  ':<C-U>TmuxNavigateLeft<cr>' },
    { '<C-j>',  ':<C-U>TmuxNavigateDown<cr>' },
    { '<C-k>',  ':<C-U>TmuxNavigateUp<cr>' },
    { '<C-l>',  ':<C-U>TmuxNavigateRight<cr>' },
    { '<C-\\>', ':<C-U>TmuxNavigatePrevious<cr>' },
  },
}
