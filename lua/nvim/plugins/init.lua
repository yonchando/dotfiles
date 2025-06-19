return {
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

}
