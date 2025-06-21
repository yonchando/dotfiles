return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { "christoomey/vim-tmux-navigator", },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { "famiu/bufdelete.nvim" },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local ls = require("luasnip")

            require("luasnip.loaders.from_snipmate").lazy_load()

            vim.keymap.set({ "i" }, '<C-K>', ls.expand, { silent = true })

            vim.keymap.set({ "i" }, '<C-L>', function() ls.jump(1) end, { silent = true })

            vim.keymap.set({ "i" }, '<C-H>', function() ls.jump(-1) end, { silent = true })
        end
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure()

            vim.api.nvim_set_hl(0, "Visual", { bg = "#2d3f76" })
            vim.api.nvim_set_hl(0, "IlluminatedWordColor", { bg = "#23315c" })

            -- change the highlight style
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "IlluminatedWordColor" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordColor" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordColor" })

            --- auto update the highlight style on colorscheme change
            vim.api.nvim_create_autocmd({ "ColorScheme" }, {
                pattern = { "*" },
                callback = function(ev)
                    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "IlluminatedWordColor" })
                    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordColor" })
                    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordColor" })
                end
            })
        end
    },
    {
        'andymass/vim-matchup',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    {
        'mg979/vim-visual-multi',
        branch = 'master'
    },
    {
        'yonchando/my-spaces.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require("my_spaces").setup()

            vim.keymap.set("n", "<leader>ml", vim.cmd.ListSpace, { desc = "[M]y workpaces [L]ist" })
        end
    }

}
