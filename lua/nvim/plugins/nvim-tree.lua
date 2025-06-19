return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local api = require("nvim-tree.api")
        local nvim_tree = require("nvim-tree")
        nvim_tree.setup({
            on_attach = function(bufnr)
                local opts = function(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)
            end
        })


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
