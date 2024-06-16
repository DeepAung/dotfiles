return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "[A]dd file in harpoon list" })
    vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "toggle [H]arpoon list" })

    for i=1,9 do
      vim.keymap.set("n", "<leader>"..i, function() harpoon:list():select(i) end, { desc = "goto [".. i .."]st buffer" })
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end, { desc = "goto [P]revious buffer" })
    vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = "goto [N]ext buffer" })
  end,
}
