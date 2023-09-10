vim.g.mapleader = " "

vim.o.relativenumber = true

vim.keymap.set({"n","v"},"J","3j")
vim.keymap.set({"n","v"},"K","3k")
vim.keymap.set({"n","v"},"L","e")
vim.keymap.set({"n","v"},"H","b")

vim.keymap.set("n", "<leader>pv", vim.cmd.Exp)
