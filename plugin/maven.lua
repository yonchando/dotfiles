require("maven").setup()

vim.keymap.set("n", "<leader>mm", function()
	vim.cmd("Maven")
end)

vim.keymap.set("n", "<leader>mr", function()
	vim.cmd("MavenExec")
end)

vim.keymap.set("n", "<leader>mt", function()
	vim.cmd("MavenTest")
end)

vim.keymap.set("n", "<leader>mf", function()
	vim.cmd("MavenFavorites")
end)
