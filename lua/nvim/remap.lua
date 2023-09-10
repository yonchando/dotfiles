vim.g.mapleader = " "
vim.o.shiftwidth = 4
vim.o.relativenumber = true

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set({"n","v"}, "L","e")
vim.keymap.set({"n","v"}, "H","b")
vim.keymap.set({"n","v"}, "J","3j")
vim.keymap.set({"n","v"}, "K","3k")

vim.keymap.set("n", "<leader>pa",'"ap')
vim.keymap.set("n", "<leader>ps",'"sp')
vim.keymap.set("n", "<leader>pd",'"dp')

vim.keymap.set("v", "<leader>ya",'"ay')
vim.keymap.set("v", "<leader>ys",'"sy')
vim.keymap.set("v", "<leader>yd",'"dy')
