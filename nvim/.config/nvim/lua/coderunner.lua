local lang_maps = {
  cpp = { build = 'g++ "$FILE" -o "$FILE_BASE"', exec = './"$FILE_BASE"' },
  c = { build = 'gcc "$FILE" -o "$FILE_BASE"', exec = './"$FILE_BASE"' },
  python = { exec = 'python3 "$FILE"' },
  lua = { exec = 'lua "$FILE"' },
  sh = { exec = 'bash "$FILE"' },
  go = { build = 'go build -o "$FILE_BASE" "$FILE"', exec = './"$FILE_BASE"' },
  rust = { exec = 'cargo run' },
  javascript = { exec = 'node "$FILE"' },
  typescript = { exec = 'ts-node "$FILE"' },
}

local function get_vars()
  local file = vim.fn.expand('%')
  local file_base = vim.fn.expand('%:r')
  return file, file_base
end

local function get_lang_data()
  local lang = lang_maps[vim.bo.filetype]
  if lang == nil then
    vim.notify('CodeRunner: Language "' .. vim.bo.filetype .. '" not supported', vim.log.levels.WARN)
    return nil
  end
  return lang
end

-- Helper to substitute variables in the command string
local function prepare_cmd(cmd_template)
  local file, file_base = get_vars()
  -- Escape paths to handle spaces safely
  local cmd = cmd_template:gsub('%$FILE_BASE', file_base):gsub('%$FILE', file)
  return cmd
end

local function run_code(mode)
  vim.cmd('write') -- Auto-save before running

  local data = get_lang_data()
  if data == nil then
    return
  end

  local cmd = ''

  -- 1. Build Only
  if mode == 'build' then
    if data.build == nil then
      vim.notify('CodeRunner: No build command for ' .. vim.bo.filetype, vim.log.levels.WARN)
      return
    end
    cmd = prepare_cmd(data.build)
    -- Run build in standard command line (blocking, so we see errors immediately)
    vim.cmd('!' .. cmd)

  -- 2. Exec Only
  elseif mode == 'exec' then
    if data.exec == nil then
      vim.notify('CodeRunner: No exec command for ' .. vim.bo.filetype, vim.log.levels.WARN)
      return
    end
    cmd = prepare_cmd(data.exec)
    -- Open split and run term
    vim.cmd('split | terminal ' .. cmd)
    vim.cmd('startinsert')

  -- 3. Run (Build + Exec)
  elseif mode == 'run' then
    local exec_cmd = prepare_cmd(data.exec)

    -- If there is a build command, chain it: build && exec
    if data.build then
      local build_cmd = prepare_cmd(data.build)
      cmd = build_cmd .. ' && ' .. exec_cmd
    else
      cmd = exec_cmd
    end

    -- Open split and run the combined chain
    vim.cmd('split | terminal ' .. cmd)
    vim.cmd('startinsert')
  end
end

-- Keymaps
vim.keymap.set('n', '<leader>cb', function()
  run_code('build')
end, { desc = '[C]ode [B]uild' })
vim.keymap.set('n', '<leader>ce', function()
  run_code('exec')
end, { desc = '[C]ode [E]xec' })
vim.keymap.set('n', '<leader>cr', function()
  run_code('run')
end, { desc = '[C]ode [R]un (Build & Exec)' })
