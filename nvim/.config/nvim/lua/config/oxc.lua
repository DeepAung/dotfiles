local M = {}

M.eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}

M.oxfmt_config_files = {
  '.oxfmtrc.json',
  '.oxfmtrc.jsonc',
  'oxfmt.config.ts',
  'oxfmt.config.js',
}

M.oxlint_config_files = {
  '.oxlintrc.json',
  '.oxlintrc.jsonc',
  'oxlint.config.ts',
  'oxlint.config.js',
}

M.web_project_root_markers = {
  { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' },
  { '.git' },
}

M.deno_root_markers = {
  'deno.json',
  'deno.jsonc',
  'deno.lock',
}

local function has_config(bufnr, files)
  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  if buf_name == '' then
    return false
  end
  local found = vim.fs.find(files, {
    upward = true,
    path = buf_name,
  })
  return #found > 0
end

local function has_config_in_dir(dir_path, files)
  if not dir_path or dir_path == '' then
    return false
  end
  for _, file in ipairs(files) do
    if vim.uv.fs_stat(dir_path .. '/' .. file) then
      return true
    end
  end
  return false
end

local function file_contains(path, pattern)
  local file = io.open(path, 'r')
  if not file then
    return false
  end

  local content = file:read('*a')
  file:close()

  return content ~= nil and content:find(pattern) ~= nil
end

function M.has_oxfmt_config(bufnr)
  return has_config(bufnr, M.oxfmt_config_files)
end

function M.has_oxlint_config(bufnr)
  return has_config(bufnr, M.oxlint_config_files)
end

function M.has_oxfmt_dir(dir_path)
  return has_config_in_dir(dir_path, M.oxfmt_config_files)
end

function M.has_oxlint_dir(dir_path)
  return has_config_in_dir(dir_path, M.oxlint_config_files)
end

function M.has_package_json_field(bufnr, field_pattern, stop_dir)
  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  if buf_name == '' then
    return false
  end

  local dir = vim.fs.dirname(buf_name)
  while dir do
    if file_contains(dir .. '/package.json', field_pattern) then
      return true
    end

    if dir == stop_dir then
      break
    end

    local parent = vim.fs.dirname(dir)
    if not parent or parent == dir then
      break
    end
    dir = parent
  end

  return false
end

function M.web_project_root(bufnr)
  return vim.fs.root(bufnr, M.web_project_root_markers) or vim.fn.getcwd()
end

function M.is_deno_project(bufnr)
  return vim.fs.root(bufnr, M.deno_root_markers) ~= nil
end

return M
