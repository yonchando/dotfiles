return {
    -- dir = "/mnt/d/code/lua/http.nvim",
    "yonchando/http.nvim",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local http = require("http-nvim")

        http.setup()

        vim.keymap.set("n", "<leader>hrl", http.run_last, { desc = "[HttpRun] re-run recently" })

        vim.keymap.set("n", "<leader>hrp", http.last_result, { desc = "[HttpRun] Preview recently run" })

        vim.keymap.set("n", "<leader>hrc", ":HttpRun<CR>", { silent = true })
    end
}
