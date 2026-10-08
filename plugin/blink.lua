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
                    { "source_name" }
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
                    kind_icon = {
                        text = function(ctx)
                            local icon = ctx.kind_icon
                            if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                if dev_icon then
                                    icon = dev_icon
                                end
                            else
                                icon = require("lspkind").symbol_map[ctx.kind] or ""
                            end

                            return icon .. ctx.icon_gap
                        end,
                        highlight = function(ctx)
                            local hl = ctx.kind_hl
                            if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                if dev_icon then
                                    hl = dev_hl
                                end
                            end
                            return hl
                        end,
                    }
                },
                treesitter = { "lsp" }
            }
        },

        ghost_text = { enabled = false },
    },

    sources = {
        -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
        default = { 'lazydev', 'lsp', 'path' },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
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
