return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        -- "nvim-treesitter/nvim-treesitter-textobjects",
    },
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local tree = require("nvim-treesitter")

        tree.install({
            "lua",
            "vimdoc",
            "html",
            "javascript",
            "typescript", "java", "http", "bash",
            "json", "xml", "yaml",
            "angular",
            "javadoc",
            "php"
        })

        local opts = function(tbl)
            return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
        end
        vim.keymap.set("n", "<leader>tp", vim.cmd.InspectTree, opts({ desc = "Treesitter playground" }))

        for _, value in pairs(tree.get_installed()) do
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { value },
                callback = function()
                    vim.treesitter.start()
                end
            })
        end
    end
}
