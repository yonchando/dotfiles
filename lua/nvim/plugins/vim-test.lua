return {
    "vim-test/vim-test",
    config = function()
        vim.keymap.set("n", "<leader>re", ":TestNearest<CR>")
        vim.keymap.set("n", "<leader>rf", ":TestFile<CR>")
        vim.keymap.set("n", "<leader>ra", ":TestSuite<CR>")
        vim.keymap.set("n", "<leader>rl", ":TestLast<CR>")
        vim.keymap.set("n", "<leader>rc", ":TestVisit<CR>")
    end
}
