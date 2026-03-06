return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local api = require("nvim-tree.api")

        local nvim_tree = require("nvim-tree")

        nvim_tree.setup({
            view = {
                number = true,
                relativenumber = true,
            },
            renderer = {
                icons = {
                    show = {
                        git = false
                    },
                },
                highlight_git = true,
                indent_markers = {
                    enable = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    }
                }
            },
            on_attach = function(bufnr)
                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set("n", "<Esc>", "<C-w>l", { buffer = bufnr })
                vim.keymap.set("n", "<Right>", ":NvimTreeResize +20<CR>", { buffer = bufnr, silent = true })
                vim.keymap.set("n", "<Left>", ":NvimTreeResize -20<CR>", { buffer = bufnr, silent = true })
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

        vim.keymap.set("n", "<leader>gf", function()
            local file = vim.api.nvim_buf_get_name(0)

            api.tree.find_file({
                buf = file,
                open = true,
                focus = true
            })
        end, { desc = "Go to current file in nvimtree" })

        vim.keymap.set("n", "<A-1>", nvimtreeToggle, opts({ desc = "Explorer toggle" }))
    end
}
