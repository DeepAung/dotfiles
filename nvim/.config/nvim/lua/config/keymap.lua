-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>')

vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'n', 'v' }, 'L', '$')

vim.keymap.set('n', '<A-h>', ':vertical resize +5<CR>')
vim.keymap.set('n', '<A-j>', ':resize -5<CR>')
vim.keymap.set('n', '<A-k>', ':resize +5<CR>')
vim.keymap.set('n', '<A-l>', ':vertical resize -5<CR>')

vim.keymap.set('n', '<leader><Tab>', ':tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<leader><S-Tab>', ':tabprevious<CR>', { desc = 'Go to previous tab' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader><leader>x', ':source %<cr>', { desc = 'source file' })
vim.keymap.set('n', '<leader>x', ':.lua<cr>', { desc = 'source line' })
vim.keymap.set('v', '<leader>x', ':lua<cr>', { desc = 'source selected' })

vim.keymap.set('n', '<C-p>', ':cprev<CR>', { desc = 'cprev' })
vim.keymap.set('n', '<C-n>', ':cnext<CR>', { desc = 'cnext' })

vim.keymap.set('n', '<leader>yr', function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('+', path)
  vim.notify('Copied relative path: ' .. path)
end, { desc = 'Copy relative file path' })

vim.keymap.set('n', '<leader>ya', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Copied absolute path: ' .. path)
end, { desc = 'Copy absolute file path' })

vim.keymap.set('n', '<leader>xo', function()
  -- Get absolute path of current buffer
  local file_path = vim.fn.expand('%:p')

  -- Ensure the buffer is a valid file on disk
  if file_path ~= '' and vim.bo.buftype == '' then
    -- Save file changes first
    vim.cmd('write')
    -- Execute xdg-open asynchronously using vim.ui.open (Neovim 0.10+)
    -- Fallback to system command if on an older version
    if vim.ui and vim.ui.open then
      vim.ui.open(file_path)
    else
      vim.fn.system({ 'xdg-open', file_path })
    end
  else
    vim.notify('Current buffer is not a valid file', vim.log.levels.WARN)
  end
end, { desc = 'Open current buffer with xdg-open' })
