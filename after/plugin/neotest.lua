require("neotest").setup({
    adapters = {
        require("neotest-phpunit"),
    }
})

-- vim.keymap.set("n","<leader>tf", runTest(),{ desc = "[T]est Current [F]ile"})
vim.keymap.set("n", "<leader>tf", function() return require("neotest").run.run() end, {desc = "[T]est Current [F]ile"})
