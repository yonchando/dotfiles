return {
    'vim-test/vim-test',
    enabled = false,
    config = function()
        vim.g["test#strategy"] = "neovim"
        vim.g["test#preserve_screen"] = 1
        vim.g["test#neovim#start_normal"] = 1

        vim.keymap.set("n", "<leader>re", ":TestNearest<CR>")
        vim.keymap.set("n", "<leader>ra", ":TestLast<CR>")
        vim.keymap.set("n", "<leader>rf", ":TestFile<CR>")
    end
}
