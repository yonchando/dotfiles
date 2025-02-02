return {
    'yonchando/my-spaces.nvim',
    -- dir = "/home/chando/code/my-spaces",
    config = function()
        local my_spaces = require('my_spaces')
        my_spaces.setup()
        -- My spaces
        vim.keymap.set("n", "<leader>ml", vim.cmd.ListSpace, { desc = "[M]y workpaces [L]ist" })

        vim.keymap.set("n", "<leader>m1", function() my_spaces.go_to(1) end, { desc = "Go to index 1" })
        vim.keymap.set("n", "<leader>m2", function() my_spaces.go_to(2) end, { desc = "Go to index 2" })
        vim.keymap.set("n", "<leader>m3", function() my_spaces.go_to(3) end, { desc = "Go to index 3" })
        vim.keymap.set("n", "<leader>m4", function() my_spaces.go_to(4) end, { desc = "Go to index 4" })
        vim.keymap.set("n", "<leader>m5", function() my_spaces.go_to(5) end, { desc = "Go to index 5" })
        vim.keymap.set("n", "<leader>m6", function() my_spaces.go_to(6) end, { desc = "Go to index 6" })
        vim.keymap.set("n", "<leader>m7", function() my_spaces.go_to(7) end, { desc = "Go to index 7" })
        vim.keymap.set("n", "<leader>m8", function() my_spaces.go_to(8) end, { desc = "Go to index 8" })
        vim.keymap.set("n", "<leader>m9", function() my_spaces.go_to(9) end, { desc = "Go to index 9" })
    end
}
