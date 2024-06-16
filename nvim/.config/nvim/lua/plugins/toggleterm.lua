return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({})
    vim.keymap.set("n", "<leader>t.", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
    vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Toggle [H]orizontal terminal" })
    vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "Toggle [V]ertical terminal" })
    vim.keymap.set("n", "<leader>tt", ":ToggleTerm direction=tab<CR>", { desc = "Toggle [T]ab terminal" })
    vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Toggle [F]loat terminal" })
    vim.keymap.set("n", "<leader>ta", ":ToggleTermToggleAll<CR>", { desc = "Toggle [A]ll terminal" })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
    local function toggle_lazygit() lazygit:toggle(nil, "tab") end
    vim.keymap.set("n", "<leader>lg", toggle_lazygit, { desc = "Toggle [L]azy[G]it" })
  end,
}
