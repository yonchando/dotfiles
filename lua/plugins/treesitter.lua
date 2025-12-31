return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
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
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
            local treesitter_textobjects = require("nvim-treesitter-textobjects")
            local select = require("nvim-treesitter-textobjects.select")

            treesitter_textobjects.setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = true,
                }
            })

            vim.keymap.set({ "x", "o" }, "aa", function()
                select.select_textobject("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ia", function()
                select.select_textobject("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "af", function()
                select.select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                select.select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@class.inner", "textobjects")
            end)
            -- You can also use captures from other query groups like `locals.scm`
            vim.keymap.set({ "x", "o" }, "as", function()
                select.select_textobject("@local.scope", "locals")
            end)

            vim.keymap.set("n", "<leader>a", function()
                require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
            end)
        end
    },
}
