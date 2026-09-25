local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    cmdline = { enabled = true },
    completion = {
        keyword = { range = 'prefix' },

        accept = { auto_brackets = { enabled = false }, },

        list = { selection = { preselect = false, auto_insert = true } },

        menu = {
            auto_show = true,

            draw = {
                columns = {
                    { "kind_icon",  "kind",              gap = 1 },
                    { "label",      "label_description", gap = 1 },
                    { "source_name" },
                },
                components = {
                    label = {
                        text = function(ctx)
                            return ctx.label .. ctx.label_description
                        end,
                    },
                    source_name = {
                        text = function(ctx)
                            return "[" .. ctx.source_name .. "]"
                        end,
                        highlight = "BlinkCmpSource",
                    },
                },
                treesitter = { "lsp" }
            }
        },
        documentation = { auto_show = false },
        ghost_text = { enabled = true },
    },

    sources = {
        -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
        default = { 'lsp', 'path' },
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
