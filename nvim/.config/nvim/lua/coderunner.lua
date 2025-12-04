local lang_maps = {
  cpp = { build = 'g++ % -o %:r', exec = './%:r' },
  c = { build = 'g++ % -o %:r', exec = './%:r' },
  python = { exec = 'python3 %' },
  sh = { exec = './%' },
  go = { build = 'go build', exec = 'go run %' },
  rust = { exec = 'cargo run' },
  javascript = { exec = 'node %' },
  typescript = { exec = 'node %' },
}

local function get_lang_data()
  local lang = lang_maps[vim.bo.filetype]
  if lang == nil then
    print('error: lang for filetype ' .. vim.bo.filetype .. ' not found')
    return nil
  end

  return lang
end

local function build_command()
  local data = get_lang_data()
  if data == nil then
    return
  end

  if data.build == nil then
    print("error: lang didn't have a build command")
    return
  end

  local key = vim.api.nvim_replace_termcodes(':!' .. data.build .. '<CR>', true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

local function exec_command()
  local data = get_lang_data()
  if data == nil then
    return
  end

  if data.exec == nil then
    print("error: lang didn't have a exec command")
    return
  end

  local key = vim.api.nvim_replace_termcodes(':split<CR>:terminal ' .. data.exec .. '<CR>' .. 'i', true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

vim.keymap.set('n', '<leader>cb', build_command, { desc = '[B]uild command' })
vim.keymap.set('n', '<leader>ce', exec_command, { desc = '[E]xec command' })
vim.keymap.set('n', '<leader>cr', function()
  build_command()
  exec_command()
end, { desc = '[R]un command ([B]uild and [E]xec)' })
