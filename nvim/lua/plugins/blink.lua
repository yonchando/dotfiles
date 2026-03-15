return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        { "L3MON4D3/LuaSnip",     run = "make install_jsregexp" },
        'onsails/lspkind.nvim',
        { "neovim/nvim-lspconfig" },
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',

            ['C-h'] = { 'snippet_backward', 'fallback' },
            ['C-l'] = { 'snippet_forward', 'fallback' },

            ['C-j'] = {
                function(cmp)
                    cmp.show({
                        providers = { "snippets" }
                    })
                end,
            }
        },

        appearance = {
            nerd_font_variant = 'mono',
        },

        completion = {
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                }
            },
            trigger = {
                show_on_trigger_character = true
            }
        },

        cmdline = {
            completion = { menu = { auto_show = true } }
        },

        snippets = { preset = 'luasnip' },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        }
    }
}
