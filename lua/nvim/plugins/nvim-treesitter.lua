return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter_config = require('nvim-treesitter.configs')

        treesitter_config.setup({
            modules = {},
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
            sync_install = false,
            auto_install = true,
            ignore_install = {},

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,

                    keymaps = {
                        ["ac"] = { query = "@class.outer", desc = "Select outer class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },

                        ["af"] = { query = "@function.outer", desc = "Select outer function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner function" },

                        ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
                        ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },

                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    }
                }
            },
        })
    end
}
