local ok, my_spaces = pcall(require, "my_spaces")

if not ok then
    return
end

my_spaces.setup()

-- My spaces
vim.keymap.set("n", "<leader>ml", vim.cmd.ListSpace, { desc = "[M]y workpaces [L]ist" })
vim.keymap.set("n", "<leader>mr", vim.cmd.RemoveSpace, { desc = "[M]y workpaces [R]emove List" })
