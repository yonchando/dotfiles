return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local nvim_tree = require("nvim-tree")
        nvim_tree.setup()

        local api = require("nvim-tree.api")

        local opts = function(tbl)
            return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
        end

        local nvimtreeToggle = function()
            local tree = api.tree

            if tree.is_tree_buf() then
                tree.close()
            else
                tree.open()
            end
        end


        vim.keymap.set("n", "<A-1>", nvimtreeToggle, opts({ desc = "Explorer toggle" }))
    end
}
