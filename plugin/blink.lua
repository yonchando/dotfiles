local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    cmdline = { enabled = true },
    completion = {
        keyword = { range = 'prefix' },

        accept = { auto_brackets = { enabled = false }, },

        list = { selection = { preselect = false, auto_insert = true } },

        menu = {
            auto_show = false,

            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind" }
                },
            }
        },
        documentation = { auto_show = false },
        ghost_text = { enabled = true },
    },

    sources = {
        -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
        default = { 'buffer' },
    },

    snippets = { preset = 'luasnip' },

    keymap = {
        preset = 'default',

        ['<C-Space>'] = {
            function(c)
                return c.show({
                    providers = { 'lsp', 'path' }
                })
            end
        },
        ['<C-j>'] = {
            function(c)
                return c.show({
                    providers = { 'snippets' }
                })
            end
        }
    }
})
