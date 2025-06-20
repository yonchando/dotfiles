return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    branch = 'master',
    build = ":TSUpdate",
    config = function()
        local treesitter_config = require('nvim-treesitter.configs')


        local opts = function(tbl)
            return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
        end
        vim.keymap.set("n", "<leader>tp", vim.cmd.InspectTree, opts({ desc = "Treesitter playground" }))
        vim.keymap.set("n", "<leader>td", function()
            vim.cmd('TSUpdate dbdiagram')
        end, opts({ desc = "TSUpdate dbdiagram" }))

        treesitter_config.setup({
            modules = {},
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "regex",
            },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
                disable = {
                    'html',
                }
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = ']w',
                    node_incremental = ']w',
                    node_decremental = '[w',
                },
            },
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
