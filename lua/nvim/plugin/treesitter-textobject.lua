local status, config = pcall(require, 'nvim-treesitter.configs')

if not status then
    return
end

config.setup({
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
    },
})
