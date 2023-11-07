return {
    'yonchando/my-spaces.nvim',
    config = function()
        require('my_spaces').setup()

        -- My spaces
        vim.keymap.set("n", "<leader>ml", vim.cmd.ListSpace, { desc = "[M]y workpaces [L]ist" })
        vim.keymap.set("n", "<leader>mr", vim.cmd.RemoveSpace, { desc = "[M]y workpaces [R]emove List" })
    end
}
