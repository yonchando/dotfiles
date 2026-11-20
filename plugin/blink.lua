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
                    { "kind_icon",  "kind", gap = 1 },
                    { "label",      gap = 1 },
                    { "source_name" }
                },
                components = {
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                },
            }
        },

        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },

        ghost_text = { enabled = false },
    },

    sources = {
        default = { 'lazydev', 'lsp', 'path', 'buffer' },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
        },
    },

    snippets = { preset = 'luasnip' },

    keymap = {
        preset = 'default',

        ['<A-2>'] = { function(c) c.accept({ index = 2 }) end },
        ['<A-3>'] = { function(c) c.accept({ index = 3 }) end },
        ['<A-4>'] = { function(c) c.accept({ index = 4 }) end },
        ['<A-5>'] = { function(c) c.accept({ index = 5 }) end },
        ['<A-6>'] = { function(c) c.accept({ index = 6 }) end },
        ['<A-7>'] = { function(c) c.accept({ index = 7 }) end },
        ['<A-8>'] = { function(c) c.accept({ index = 8 }) end },
        ['<A-9>'] = { function(c) c.accept({ index = 9 }) end },
        ['<A-0>'] = { function(c) c.accept({ index = 10 }) end },

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
