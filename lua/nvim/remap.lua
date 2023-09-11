vim.g.mapleader = " "
vim.o.shiftwidth = 4
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true

vim.keymap.set("n", "<leader><space>", vim.cmd.WhichKey, { desc = "Show all mapping" })
vim.keymap.set("n", "<leader><tab>", vim.cmd.NvimTreeToggle, { desc = "NvimTreeToggle" })
vim.keymap.set("n", "<leader>1", vim.cmd.NvimTreeFocus,{desc = "NvimTreeFocus" })

vim.keymap.set({"n","v"}, "L","e", {desc = "Next word at end of word" })
vim.keymap.set({"n","v"}, "H","b", {desc = "Back word at start of word" })
vim.keymap.set({"n","v"}, "J","3j", {desc = "Move coursor down 3 line" })
vim.keymap.set({"n","v"}, "K","3k", {desc = "Move coursor up 3 line" })

vim.keymap.set("n", "<leader>pa",'"ap',{desc = "Paste text store in char a" })
vim.keymap.set("n", "<leader>ps",'"sp', {desc = "Paste text store in char s" })
vim.keymap.set("n", "<leader>pd",'"dp', {desc = "Paste text store in char d" })

vim.keymap.set("v", "<leader>ya",'"ay', {desc = "Yank text in char a" })
vim.keymap.set("v", "<leader>ys",'"sy', {desc = "Yank text in char s" })
vim.keymap.set("v", "<leader>yd",'"dy', {desc = "Yank text in char d" })
