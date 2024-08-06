vim.bo.tabstop = 4     -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 4  -- size of an indentation (sw).
vim.bo.softtabstop = 4 -- number of spaces a <Tab> counts for. When 0, feature is off (sts).

vim.keymap.set('n', '<leader>cpa', ':CompetiTest add_testcase<CR>')
vim.keymap.set('n', '<leader>cpe', ':CompetiTest edit_testcase<CR>')
vim.keymap.set('n', '<leader>cpd', ':CompetiTest delete_testcase<CR>')
vim.keymap.set('n', '<leader>cpr', ':CompetiTest run<CR>')
vim.keymap.set('n', '<leader>cpx', ':CompetiTest run_no_compile<CR>')
