local M = {}

M.ignore_format_on_save_list = { cpp = true, c = true }

M.ignore_format_on_save = function(filetype)
  return M.ignore_format_on_save_list[filetype] ~= nil
end

M.custom_format = function()
  local filetype = vim.bo.filetype

  if filetype == 'templ' then
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local cmd = 'templ fmt ' .. vim.fn.shellescape(filename)

    vim.fn.jobstart(cmd, {
      on_exit = function()
        -- Reload the buffer only if it's still the current buffer
        if vim.api.nvim_get_current_buf() == bufnr then
          vim.cmd 'e!'
        end
      end,
    })
    return
  end

  vim.lsp.buf.format { async = false }
end

return M
