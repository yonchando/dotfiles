return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'neovim/nvim-lspconfig',
        'L3MON4D3/LuaSnip'
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'default',

            ['C-j'] = { function(cmp)
                cmp.show({ providers = { 'snippets' } })
            end, 'fallback' },

            ['C-h'] = { 'snippet_backward', 'fallback' },
            ['C-l'] = { 'snippet_forward', 'fallback' },
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

        snippets = { preset = 'luasnip' },

        sources = {
            default = { 'lsp', 'path', 'buffer' }
        }
    },
}
