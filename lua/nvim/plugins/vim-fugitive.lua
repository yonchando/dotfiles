return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", function() vim.cmd('Git') end, { desc = "Git Status" })
        vim.keymap.set("n", "<leader>gc", function() vim.cmd('Git commit') end, { desc = "Git Commits" })
        vim.keymap.set("n", "<leader>gd", function() vim.cmd('Git diff') end, { desc = "Git diff" })
        vim.keymap.set("n", "<leader>gl", function() vim.cmd('Git log') end, { desc = "Git log" })
        vim.keymap.set("n", "<leader>gaa", function() vim.cmd('Git add .') end, { desc = "Git add all" })
        vim.keymap.set("n", "<leader>gmtl", function() vim.cmd('Git mergetool') end, { desc = "Git mergetool" })
        vim.keymap.set("n", "<leader>gp", function() vim.cmd('Git push') end, { desc = "Git push" })
        vim.keymap.set("n", "<leader>gl", function() vim.cmd('Git pull') end, { desc = "Git pull" })
    end
}
