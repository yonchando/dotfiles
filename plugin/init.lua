require("nvim-autopairs").setup {}

-- indent blankline
require("ibl").setup({
    scope = {
        show_start = false,
        show_end = false,
    }
})
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.fillchars:append("lastline:⋅")

-- multiple cursor
require("multiple-cursors").setup()
vim.keymap.set({ "n", "x" }, "<C-n>", function() vim.cmd('MultipleCursorsAddDown') end,
    { desc = "Add multiple cursor down" })
vim.keymap.set({ "n", "x" }, "<C-p>", function() vim.cmd('MultipleCursorsAddUp') end, { desc = "Add multiple cursor up" })
vim.keymap.set({ "n", "x" }, "<A-j>", function() vim.cmd('MultipleCursorsAddJumpNextMatch') end,
    { desc = "Select next match" })
vim.keymap.set({ "n", "x" }, "<A-k>", function() vim.cmd('MultipleCursorsAddJumpPrevMatch') end,
    { desc = "Select previous match" })
vim.keymap.set({ "n", "x" }, "<A-x>", function() vim.cmd('MultipleCursorsJumpNextMatch') end,
    { desc = "Add multiple cursor up" })

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
    desc = "Undo tree toggle"
})
