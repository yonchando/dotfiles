return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'neovim/nvim-lspconfig',
        'L3MON4D3/LuaSnip',
        'onsails/lspkind.nvim',
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'default',
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

        cmdline = {
            keymap = { preset = 'inherit' },
            completion = { menu = { auto_show = true } }
        },

        snippets = { preset = 'luasnip' },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'dbd' },

            providers = {
                dbd = {
                    name = "DB Diagram",
                    module = 'dbdiagram',
                    opts = {}
                }
            }
        }
    }
}
