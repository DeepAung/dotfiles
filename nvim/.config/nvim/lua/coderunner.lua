local lang_maps = {
  cpp = { build = 'g++ % -o %:r', exec = './%:r' },
  c = { build = 'g++ % -o %:r', exec = './%:r' },
  python = { exec = 'python3 %' },
  sh = { exec = './%' },
  go = { build = 'go build', exec = 'go run %' },
  rust = { exec = 'cargo run' },
  javascript = { exec = 'node %' },
  -- typescript = { build = "deno compile %", exec = "deno run %" },
}

local build_command = function()
  local data = get_lang_data()
  if data == nil then
    return
  end

  if data.build == nil then
    print "error: lang didn't have a build command"
    return
  end

  local key = vim.api.nvim_replace_termcodes(':!' .. data.build .. '<CR>', true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

local exec_command = function()
  local data = get_lang_data()
  if data == nil then
    return
  end

  if data.exec == nil then
    print "error: lang didn't have a exec command"
    return
  end

  local key = vim.api.nvim_replace_termcodes(':split<CR>:terminal ' .. data.exec .. '<CR>', true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

vim.keymap.set('n', '<leader>cb', build_command, { desc = '[B]uild command' })
vim.keymap.set('n', '<leader>ce', exec_command, { desc = '[E]xec command' })

function get_lang_data()
  local lang = lang_maps[vim.bo.filetype]
  if lang == nil then
    print('error: lang for filetype ' .. vim.bo.filetype .. ' not found')
    return nil
  end

  return lang
end
